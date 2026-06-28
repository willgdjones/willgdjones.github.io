---
layout: post
title: 'Four walls: how Apple silently blocks third-party Reminders subtask writes'
date: '2026-04-23'
description: I wanted my AI todo agent to ask questions by posting subtasks to Apple
  Reminders. Apple refuses this at four separate layers, the last one silently. This
  is the story of finding each wall.
---

<!-- Generated from Obsidian. Edit the source note instead. -->

I'm building an AI todo app. The conceit is simple: each todo is an agent that runs itself in the background and comes back to you when it needs input. Since I'd like the agent questions to reach me on my phone without building a new app, the obvious surface is **Apple Reminders**. An aitodo task = a top-level reminder. The agent's question to me = a subtask under it. I tap the subtask to answer. One tap, no new UI, works on Mac / iPhone / Watch / Siri for free.

I thought the hard part of this project would be the agent loop. It turned out to be reminders subtasks.

This post is the story of how far I got trying to create a Reminders subtask from a third-party macOS process, and what I found at each successive wall. The ending is worse than I expected.

## The goal

In Apple Reminders, a **subtask** is a reminder nested under another reminder:

![subtask in Reminders UI](/assets/images/placeholder-subtask.png)

On iPhone you swipe-right to indent. On Mac you drag, or sometimes Tab works. It's shipped in the UI since iOS 13 (2019). It syncs over iCloud, shows up in the Today widget, notifies independently of its parent. Ordinary, long-established feature.

I wanted: given a parent `EKReminder`, create a subtask under it, from Swift, without shipping a full macOS app.

## Wall 1: EventKit

EventKit is the public Apple framework for Calendar and Reminders. The entire surface for a reminder is `EKReminder`, which I can just read out of the SDK headers:

```bash
$ cat /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/\
System/Library/Frameworks/EventKit.framework/Headers/EKReminder.h
```

```objc
@interface EKReminder : EKCalendarItem
+ (EKReminder *)reminderWithEventStore:(EKEventStore *)eventStore;
@property(nonatomic, copy, nullable) NSDateComponents *startDateComponents;
@property(nonatomic, copy, nullable) NSDateComponents *dueDateComponents;
@property(nonatomic, getter=isCompleted) BOOL completed;
@property(nonatomic, copy, nullable) NSDate *completionDate;
@property(nonatomic) NSUInteger priority;
@end
```

That's the whole class. `EKCalendarItem` adds title, notes, URL, calendar, alarms, and recurrence, but nothing parent-shaped. A grep across every header in the framework for the word "parent" returns one match, about parental controls.

So the public API has no concept of parent/child reminders. Any call to set one would have to come from somewhere else.

## Wall 2: AppleScript

OK, skip the native API, drive the Reminders.app via AppleScript — the scripting dictionary is the other public-ish interface Apple ships. I read `/System/Applications/Reminders.app/Contents/Resources/Reminders.sdef` carefully.

The `list` class has `<element type="reminder">`, so you can iterate reminders of a list. The `account` class does too. The `reminder` class **does not**. There's no way to enumerate the children of a reminder.

There's a `container` property on reminders, which looks hopeful:

```xml
<property name="container" code="cntr" access="r"
  description="The container of the reminder">
  <type type="list" />
  <type type="reminder" />
  <cocoa key="container" />
</property>
```

Type is `list | reminder`, so the data model does know a reminder's container can be another reminder. But `access="r"` — read-only.

Empirically:

```bash
$ osascript -e '
tell application "Reminders"
  tell list "aitodo"
    set p to first reminder whose name is "PROBE"
    tell p
      make new reminder with properties {name:"child"}
    end tell
  end tell
end tell'
execution error: Reminders got an error:
  Can't make or move that element into that container. (-10024)
```

Error `-10024`. Reminders.app tells you to your face: that element can't go in that container. The subtask relationship is *in the schema*, but no scripting verb will write it.

## Wall 3: the private ivar

At this point the normal conclusion is "impossible". But I knew Reminders.app itself sets this every day, so the capability has to exist somewhere. Time for the Objective-C runtime.

A small Swift program that calls `class_copyPropertyList` and `class_copyMethodList` on `EKReminder` reveals what the public headers don't:

```
parentID @ T@"EKObjectID",&,N,V_parentID
-parentID
-setParentID:
-clearParentID
_parentID
```

**`parentID` exists.** It's a property of type `EKObjectID`, with a getter, a setter, a clearer, and a backing ivar. Apple built it, they just didn't expose it in the header.

Good — KVC it and move on:

```swift
let child = EKReminder(eventStore: store)
child.calendar = calendar
child.title = "my subtask"
child.setValue(parentObjectID, forKey: "parentID")
try store.save(child, commit: true)
```

The save returns success. The reminder appears in the aitodo list. But it appears as a **top-level** reminder, not nested under the parent. The `container` property (via AppleScript) reports the list, not the parent.

Diagnosis via `-[EKObject changeSet]` — every save collects its modifications into an `EKChangeSet` before shipping them to the daemon. I looked at ours:

```
singleValueChanges: {
    calendar = "<EKFrozenReminderCalendar: 0x...>";
    notes = "";
    unlocalizedTitle = "my subtask";
}
multiValueAdditions: { }
multiValueRemovals: { }
```

`calendar`, `notes`, `title` all showed up. **`parentID` did not.** The setter ran and updated the ivar — `child.value(forKey: "parentID")` returned the right thing — but the change-set serializer didn't notice.

Why? `EKReminder` has a private method `-_singleRelationshipKeysToCheckForChanges`. It returns the set of relationships the serializer is willing to track:

```
{
  clientLocation, organizer, singleRecurrenceRule, selfAttendee,
  structuredLocationWithoutPrediction, calendar, syncError,
  originalItem, travelStartLocation
}
```

Nine entries. `parentReminder` is not one of them. Neither is `parentID`. Apple kept the ivar and the setter, and then pulled the relationship out of the change-tracking list by hand.

This is already interesting. The first two walls were "we didn't ship the API." This one is "we shipped the API and then specifically defanged it."

## Wall 4: directly injecting the change

If the exclusion is just a set, I can patch it. A few lines of Objective-C runtime hackery and:

- Swizzle `_singleRelationshipKeysToCheckForChanges` to return a set that also contains `"parentReminder"`.
- `class_addMethod` a `-parentReminder` method returning the current `parentID`, so the KVO machinery has a value to compare against.
- Wrap the setter call in `willChangeValueForKey:@"parentReminder"` / `didChangeValueForKey:@"parentReminder"` to fire KVO.

I ran it. The keys list now includes `parentReminder`. The `-parentReminder` getter works. KVO fires. The change-set is still empty.

Turns out the relationship-keys list isn't actually what drives inclusion in the change-set. It's a post-hoc check. The actual inclusion happens inside each setter — `setCalendar:`, `setNotes:`, etc. call an internal `_setProperty:forKey:isRelation:isUpdatedProperty:`-style registrar. `setParentID:` doesn't.

But `EKChangeSet` has its own public-within-private method: **`-forceChangeValue:forKey:`**. It takes a value and a key and shoves them straight into `singleValueChanges`, skipping every policy gate.

```swift
let cs = child.perform(NSSelectorFromString("changeSet"))?.takeUnretainedValue()
(cs as AnyObject).perform(
    NSSelectorFromString("forceChangeValue:forKey:"),
    with: parentFrozenPersistentObject,
    with: "parentReminder" as NSString
)
```

To pick the right shape of value, I looked at what `calendar` serialized as — `<EKFrozenReminderCalendar: 0x...>`, a frozen snapshot of the calendar object. So I pass the parent's `persistentObject` (an `EKFrozenReminderReminder`) by the same pattern. The change-set now shows:

```
singleValueChanges: {
    parentReminder = "<EKFrozenReminderReminder: 0x...>";
}
```

Perfect. The change is in, the shape matches how Apple's own code serializes relationships, the save returns success.

And the reminder still appears as top-level, with `ZPARENTREMINDER` NULL.

## The silent server

To confirm what's happening, I went underneath EventKit. The authoritative store is a Core Data SQLite database owned by the `remindd` daemon, at `~/Library/Group Containers/group.com.apple.reminders/Container_v1/Stores/Data-*.sqlite`. Schema for `ZREMCDREMINDER`:

```
ZPARENTREMINDER              INTEGER   -- FK to another reminder's Z_PK
ZCKPARENTREMINDERIDENTIFIER  VARCHAR   -- CloudKit UUID of the parent
```

After every one of my save attempts, both columns are NULL. Even the one where the change-set shipped a correctly-shaped `parentReminder` entry.

To prove the data model actually works, I had my iPhone create a subtask, wait for iCloud to sync, and inspected the same DB:

```
Z_PK  ZTITLE         ZPARENTREMINDER  ZCKPARENTREMINDERIDENTIFIER
----  -------------  ---------------  ------------------------------------
432   PROBE                           (null)
433   SUBTASK-PROBE  432              A8C08918-0C18-45EE-AC22-841E5A6EBEED
```

Same table. Same daemon. Same machine. Both columns populated, cleanly linking child to parent. `remindd` can write subtasks; it just wouldn't write them for me.

And: no log line in `remindd` or `calaccessd` telling me it rejected the change. `log stream --process remindd --level debug` during my save shows the reminder being created, being indexed for Spotlight, its calendar being updated — and nothing about `parentReminder`. The field is stripped somewhere between my `EKChangeSet` and the final `INSERT`, silently, with no diagnostic.

## Four walls

Let me lay them out in order:

| # | Layer | What's exposed | What happens when you write |
|---|---|---|---|
| 1 | Public EventKit (`EKReminder.h`) | Nothing parent-shaped | N/A, surface doesn't exist |
| 2 | AppleScript (`Reminders.sdef`) | `container` is read-only; no `reminders` element on a reminder | `-10024 Can't make or move that element into that container` |
| 3 | Private `parentID` ivar/setter | Ivar + setter exist | Ivar updates, but `parentReminder` is omitted from the change-tracking registrar; save ships without the field |
| 4 | `EKChangeSet.forceChangeValue:forKey:` | Full change-set machinery accessible | Change ships in the exact shape Apple uses for other relationships, save returns success, `remindd` silently drops the field |

Each wall is strictly more deliberate than the one before it. The progression is not "we didn't get around to it." It's:

- Wall 1: *we chose not to expose it.*
- Wall 2: *we chose not to expose it in the other surface either.*
- Wall 3: *we left the private ivar but removed it from the change-tracking list by hand.*
- Wall 4: *we accept your change-set, save the surrounding fields, and drop this specific one without a diagnostic.*

It's defense in depth, for a feature Apple ships in their own app, that syncs through their own iCloud, to a daemon they wrote, talking to a database they designed, on a machine I own.

## What this actually means

A few things I want to be clear about.

**This isn't a case of "eventually the private API breaks on an OS update."** I thought that's what I was getting into. It would have been fine. A demo that needs re-pinning once a year is a demo I'd happily maintain. What I found is not fragile — it's *structurally closed*. The client-side private surface is wired up to produce the right in-memory state, hand it to the save path, and have the save path drop exactly that field. The effort to make that happen is roughly equal to the effort of just exposing the API.

**It isn't a security thing.** Reading subtasks works fine — iPhone-synced subtasks come through to my third-party code in the same store. Any malicious app could enumerate "user X has scheduled N subtasks under parent Y" today. The refusal is specifically on the write path.

**It isn't a performance thing.** The save message already carries arbitrary keys, the daemon is already doing the work of accepting updates to this table from other clients (iCloud sync clients, Reminders.app itself), and the schema has the columns. The server isn't saving effort by silently dropping one field.

It reads, to me, as a product decision: *subtasks are a Reminders.app feature, not a Reminders feature*. If you want to write subtasks, ship a Reminders.app client. Third parties that want to manipulate reminders in aggregate — sync them to Notion, surface them in a dashboard, or, in my case, drive an agent loop — are welcome to everything *except* subtasks.

## Where this leaves aitodo

I designed aitodo assuming subtasks were the question-loop primitive. They're not available. So the v0 design has to change — likely either a `Q:` naming convention with sibling reminders, or checklist-items in a reminder's notes field. Both are uglier than what I wanted. Both are on public APIs.

There is a v2 world where I ship a full Reminders.app-style Mac app and get this via AppleScript into myself via UI automation, which is its own genre of sadness. For now I'm going to keep the bridge's subtask path in source control as a monument and move on.

If you work on EventKit at Apple and read this: please expose `parentReminder`. The data model exists, the sync works, your own code has been writing this field for seven years. The only thing missing is a public getter and a setter that doesn't silently drop the change.

If you're outside Apple and you hit one of these walls: I hope this post saves you the day I spent finding each one in sequence.
