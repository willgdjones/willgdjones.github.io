---
layout: post
title: "I Switched Accounting Software Because My AI Agent Couldn't Use the API"
date: 2026-02-28
description: "I moved from QuickFile to Xero not because of features I use, but because of features my AI agents can use. This is where all SaaS is heading."
draft: true
---

I recently moved my accounting software from QuickFile to Xero. Not because of the UI. Not because of the features. Because my AI agents couldn't do their job on QuickFile.

Let me explain.

## The QuickFile problem

I run an AI consultancy. Like most small businesses, I have invoices coming in from a dozen different SaaS platforms every month. I built an AI agent to handle this - find the invoices, download them, attach them to the right transactions in my accounting system. The full story is in [my last post](/essays/ai-agent-missing-invoices-2026/).

QuickFile was the cheaper option and I'd been using it for a while. Five quid a month. The interface is fine. But the API had gaps that made my agents' lives miserable.

The killer issue: you couldn't attach receipts to transactions via the API. There was simply no endpoint for it. My agent could create invoices, it could pull bank transactions, but the simple act of linking a PDF receipt to the transaction it belonged to? Browser only.

So my agent had to fall back to browser automation. Log in, navigate to the transaction, click the attach button, upload the file. It worked sometimes. Other times it got stuck on page loads, or the session expired, or the UI changed slightly and the selectors broke. Browser automation is fragile by nature. Every time QuickFile updated their frontend, something would break.

I spent more time debugging the browser workarounds than the agent itself.

## The Xero switch

Xero costs more. Significantly more. But its API is comprehensive. Attachments, bank transactions, invoices, contacts, reconciliation - everything I need my agents to do has a clean, documented endpoint.

The migration took an afternoon. My agents went from fighting with browser sessions to making clean API calls. The failure rate dropped to nearly zero. No more broken selectors, no more expired sessions, no more fragile workarounds.

I didn't switch because Xero has better reports or a nicer dashboard. I switched because my agents could actually use it.

## This is where SaaS is heading

Here's what I think is about to happen across the entire software industry: the products that win will be the ones that agents can use.

Think about how software gets evaluated today. You look at the UI, the feature list, the price, maybe the integrations. The API documentation is something a developer checks during implementation, if they check it at all.

That's changing. Fast.

When your AI agent is the primary user of a product - and increasingly, it will be - the API becomes the product. The completeness of endpoints matters more than the colour of the buttons. Documentation quality matters more than onboarding flows. Rate limits and error messages matter more than marketing pages.

QuickFile has a perfectly good product for humans. But it's missing one API endpoint for attaching receipts, and that single gap made it unusable for my agents. That's the kind of thing that will decide which products survive the next five years.

## What this means for SaaS companies

If you're building software and you're not investing heavily in API completeness right now, you're building for a world that's disappearing.

A few things I'd be thinking about:

**Every user action needs an API equivalent.** If a human can do it in your UI, an agent should be able to do it via your API. No exceptions. The moment an agent has to fall back to browser automation, you've lost.

**Documentation is the new onboarding.** Your API docs are going to be read by AI agents, not just developers. They need to be clear, consistent, and complete. Every endpoint, every parameter, every error code.

**API-first pricing makes sense.** Agents will use your product differently than humans - more API calls, more automation, potentially more value extracted. Price for that reality.

The services that are going to win are the ones with the most complete, clear, and well-documented APIs. Not the prettiest interfaces. Not the cheapest subscriptions. The ones that agents can actually work with.

APIs are becoming agent-first. The SaaS companies that understand this will thrive. The ones that don't will wonder why their customers keep switching to more expensive competitors.

I know. I just did.

williamgdjones[at]gmail.com
