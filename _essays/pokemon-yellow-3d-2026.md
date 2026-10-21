---
layout: post
title: Rebuilding Pokemon Yellow in 3D, Tile for Tile
date: '2026-10-21'
description: AI agents rebuilt Game Boy Pokemon Yellow from Pallet Town to Cerulean City in Unreal Engine, with real-time battles. The hardest part was getting them to stop improving it.
---

Pokemon Yellow is a good test for AI coding agents, because everyone knows exactly how it's supposed to look, so every mistake is visible.

Over about two weeks, agents built it in Unreal Engine 5.8: Pallet Town to Cerulean City, 46 maps in one seamless world with no loading screens, 188 people including 57 trainers, Brock and Misty, the rival, Jessie and James in Mt. Moon, and Pikachu walking a tile behind you, never in a ball.

**Download (Windows): [release v0.1](https://github.com/willgdjones/pokemon-yellow-3d/releases/tag/v0.1)** · [code](https://github.com/willgdjones/pokemon-yellow-3d)

![Pallet Town, outside Oak's lab](/assets/images/obsidian/pokemon-yellow-3d-2026/pallet-town.png)

## One big change

Everything is Game Boy Yellow except the battles, which happen in real time. You steer your Pokemon around a ring. The number keys fire moves, each with a cooldown, and Space dodges. Switching pauses the fight. Underneath, the Gen 1 numbers and Yellow's catch formula still decide what happens.

![A live battle on Route 1](/assets/images/obsidian/pokemon-yellow-3d-2026/battle.png)

## The agents kept improving it

The project started as "Pokemon Yellow, reimagined", and the first milestone did exactly that: it reimagined the TV show. There was a scene with sprinklers soaking Brock's Onix. It was charming, and it wasn't the game.

So the brief changed: follow the Game Boy storyline exactly. Then, after the third milestone, it changed again: the world must be literally a 3D version of the exact Game Boy map. The world kept drifting from the original because the agents kept filling gaps with their own ideas.

What finally worked was taking the guesswork away. The fourth milestone extracted everything from [pret/pokeyellow](https://github.com/pret/pokeyellow), the community's disassembly of the original game: every map tile, every line of text, every trainer's team, every wild Pokemon table and every tune. From then on, the rule written at the top of the brief was: "pokeyellow is the law. Any difference is a bug."

That one sentence did more than any amount of design notes. A bug was no longer a matter of taste. You could check it.

![Brock's Onix](/assets/images/obsidian/pokemon-yellow-3d-2026/brock.png)

## Testing a world

An agent can't play a game the way you do, so the testing had to be built too. An automated QA tour walks the whole route, takes screenshots and has a model review them. Over 27 runs it logged 278 bugs. 245 were fixed and 33 were accepted as they were. More than half were warps: doors that led to the wrong place.

My favourite: Red's bedroom had four extra doors. The extractor had faithfully read some debug-only code from the original game, so the 3D version had exits that never existed on a real cartridge.

The AI reviewer wasn't perfect: it kept flagging correct scenes as wrong. The test suite grew from 85 tests at the first milestone to 415.

The music was my favourite fidelity trick. It's rendered from the Game Boy's own sound engine, so the notes, tempo, loops, vibrato and pitch slides are the originals. Only the instruments are new: accordion, tin whistle, upright bass and drums.

![Mt. Moon](/assets/images/obsidian/pokemon-yellow-3d-2026/mt-moon.png)

## The detour

At one point I tried porting the whole thing to the web with three.js, so it could run in a browser. A few milestones later I compared the two side by side and much preferred the Unreal version. The port was retired, and the Unreal game became the product again. It was a cheap lesson because the agents did the work, but a lesson all the same: decide what the bar is before you start a rewrite.

## What I learned

**Give agents a source of truth, not a description.** "Make it like the original" produced three reinterpretations. "This data is the law" produced a faithful game.

**Make "wrong" checkable.** Once every difference from pokeyellow counted as a bug, QA could find bugs without my taste in the loop.

**The agents will keep improving things you didn't ask them to.** That's helpful in a product, and a problem in a remake.

It's an unofficial, non-commercial fan project. Pokemon belongs to Nintendo, Creatures and Game Freak; my code is MIT. It's Windows only and has rough edges.
