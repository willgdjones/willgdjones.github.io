---
layout: post
title: Three Games in a Month, Built by AI Agents
date: '2026-10-21'
description: How I go from a brief to a playable game without writing the code. Swarms of agents, reviewers from a different AI company, a blind judge, and the humans who still matter most.
---

Between late September and mid October, AI agents built three games for me: [a 3D remake of Pokemon Yellow](/essays/pokemon-yellow-3d-2026/) in Unreal Engine, [a French vocabulary game](/essays/ninjago-french-2026/) for my seven-year-old, and [a reading battle game](/essays/ninjago-tournament-2026/) for my four-year-old. I wrote the briefs, made the calls and found the playtesters. I didn't write the code.

This is how that works, and what I'd tell anyone trying it.

## A brief, then milestones

Every game starts as a design brief: what it is, who it's for, what it should feel like, and what "done" means for the next milestone. A planning agent turns the milestone into tasks. Several worker agents then build those tasks in parallel, each in its own copy of the code, and an integration step merges their work.

Milestones are small on purpose. Each one ends with something playable, because the most valuable input comes from a person actually playing it.

## Reviewers from a different company

Every change is reviewed by agents from a different AI company than the one that wrote it. The idea is simple: a model reviewing its own family's work shares its blind spots. A reviewer trained differently notices different things. Work goes back for another round until the reviewer is satisfied.

## Testing what you can't see

Unit tests catch logic errors but say little about whether a game looks right. So each game gets a QA tour: an automated run through the whole game that takes screenshots and has a model check them against the brief. On the Pokemon remake, 27 runs logged 278 bugs, and 245 were fixed.

For changes that are mostly about looks, a **blind judge** decides. It sees screenshots from the current version and the candidate as "A" and "B", without knowing which is which, and the order swaps between rounds. It scores what works, how it looks and how it feels, and lists defects on each side. The new version has to win to replace the old one. It's strict: after the Pokemon game's anime-style look was accepted, the next three attempts to change its look were all turned down.

## Pacing the subscriptions

The agents run on several AI subscriptions at once. A scheduler spreads work across them so that each gets close to its limit without going over. When one hits a usage limit, the work moves to another and carries on from where it stopped, rather than waiting for the reset. The most capable model plans and reviews; cheaper models do the routine building.

## What I learned

**The brief is the product.** "Make Pokemon Yellow in 3D" kept getting creatively reinterpreted. "The original game's data is the law, any difference is a bug" got a faithful remake. Agents follow exactly what you write, so the leverage is in writing it well.

**Make quality checkable.** "Reject the picture if a child would name a different word first" let an AI review 5,000 vocabulary pictures. A vague bar like "good art" can't be applied 5,000 times the same way.

**Humans still find the important problems.** The most useful design note on the French game didn't come from a reviewer: my seven-year-old told me the core mechanic "is not useful or interesting", and he was right. No one asked my four-year-old whether his favourite art could be replaced, and he noticed straight away.

**Speed changes who drives.** When a milestone takes days, a child can steer the roadmap. That turned out to be the best part of the whole thing.

The three games are open source: [Pokemon Yellow 3D](https://github.com/willgdjones/pokemon-yellow-3d), [Ninjago French](https://github.com/willgdjones/ninjago-french) and [Ninjago Tournament](https://github.com/willgdjones/ninjago-tournament).
