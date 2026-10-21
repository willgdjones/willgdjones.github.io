---
layout: post
title: My Four-Year-Old Is My Toughest Playtester
date: '2026-10-21'
description: My son drew Kai fighting Lord Ras. A few days later he was playing it, and his notes shaped the game more than any spec I wrote.
---

My four-year-old drew me a picture. Kai battles Lord Ras with fireballs flying between them, Nya is nearby, and there is a jungle with trees and leaves, and ships. "They are battling each other," he explained, in case it wasn't obvious.

A few days later, he was playing it on the iPad.

**Play it: [ninjago-tournament.pages.dev](https://ninjago-tournament.pages.dev)** · [code](https://github.com/willgdjones/ninjago-tournament)

![Ninjago: The Endless Tournament title screen](/assets/images/obsidian/ninjago-tournament-2026/title.png)

## The brief was a drawing

He reads well for his age, but he'd only ever used tap-and-swipe apps. So the idea was simple: a battle game where reading *is* the controller. On Kai's turn you tap a word card, and the word comes to life as its own attack. Tap CAT and a cat flies at the villain. On the villain's turn, you read what's coming and tap the right word to block it, or the action word (JUMP, DUCK, ROLL) to dodge.

Every word, label and line has its own little speaker button, so a non-reader can still play by listening. Nothing reads itself aloud unless you tap it. Every target is at least 96 pixels, because four-year-old fingers are not precise instruments.

![Kai's turn: tap a word card](/assets/images/obsidian/ninjago-tournament-2026/battle.png)

## I didn't write the code

I wrote the brief, and AI coding agents built it, milestone by milestone. Agents from a different AI company reviewed every change. The whole thing is plain JavaScript with three.js, no build step, the pictures are emoji, and every sound is synthesised in the browser. That is the kind of decision you make when you want something on an iPad by the weekend.

The interesting part wasn't the code. It was the playtesting.

## The playtester is brutal

The first version was a single jungle fight. His verdict: "it is fun". High praise.

The second version was a three-fight tournament. "It's good," he said, and then gave me a list I could not have written myself: so many of the pictures don't match the word; the attack animations should match the name of the attack; there should be many more rounds which get progressively harder; there should be other things to do than just defend.

That list became the third version: endless mode. Villains come one per wave for as long as Kai lasts. Every fifth wave is a boss with a weak element. Lord Ras turns up every 25th wave. Words grow from three letters to ten as the waves climb, and a word you get right three times becomes a gold "NEW MOVE" card you keep forever. There are streaks, power-ups, a Spell It! super move, and a slow countdown on dodges from wave ten.

![Block: tap the word for the picture](/assets/images/obsidian/ninjago-tournament-2026/block.png)

He played it, and told me the graphics were worse than the last one, which he had loved.

He was right. In chasing his list, the agents had swapped the illustrated characters he liked for something plainer. Nobody had asked him whether that trade was OK, least of all me.

## What I learned

**Kids are the best product managers.** They have no politeness filter, and they tell you exactly what's boring. "Attacking with a random word isn't interesting" is a better design note than most specs I have read.

**Shipping speed changes the conversation.** When a version takes days, not months, you can afford to let a four-year-old drive the roadmap. The feedback loop is the product.

**Agents follow the brief, not the vibe.** Every item on his list was implemented. The thing he never said, "don't make it uglier", was lost. The version at the link above is the next round: every single turn is now a reading question, and the art is on the list.

It's unofficial and non-commercial, made for one child (Ninjago belongs to LEGO). The code is MIT if you want to make one for yours.
