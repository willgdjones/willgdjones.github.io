---
layout: post
title: 'Grand Tech Auto: San Francisco'
date: '2026-10-02'
description: A GTA-style multiplayer game set in real San Francisco, built in about three weeks by one person directing a swarm of AI coding agents. Play it in the browser; the code is open.
---

I live in San Francisco now, and I wanted to see whether I could build the city as a game.

**Grand Tech Auto: San Francisco** is a browser multiplayer game in the spirit of GTA, set in real San Francisco. You spawn on the Ferry Building plaza facing the clock tower, walk to a car, and drive the Embarcadero and the Lombard hills. You can hail an autonomous robotaxi, see real Tech Week events on the radar, and found a startup, buy a billboard and pitch venture capitalists for fictional funding.

Play it at [gtasf.com](https://gtasf.com). The code is at [github.com/willgdjones/grand-tech-auto-sf](https://github.com/willgdjones/grand-tech-auto-sf).

## How it was built

I didn't write most of the code. I directed a swarm of AI coding agents, each with its own lane (graphics, combat and police, missions), working in one shared repository and committing to the same branch all day. My job was deciding what the game should be and looking at what came back.

The city is real. Roads, terrain and buildings are baked from OpenStreetMap, DataSF and USGS LiDAR. The client is plain three.js and TypeScript. The server is Cloudflare Workers and Durable Objects, so two browser tabs really do see each other.

## What I learned

1. **Looking beats testing.** A module that passes in isolation can still be invisible in the game. The agents had to flip the flag and look at a real screenshot before anything counted as done.
2. **Every feature behind a flag.** With many agents committing at once, flags were the only way to keep the live game stable while the rest moved.
3. **The first minute is the product.** Early players didn't know what to do. The fix was a short guided opener: a phone rings, you walk, you get in a car, you drive.
4. **Police were too good and aiming on a keyboard was miserable.** Both are tuning problems, and tuning is where the agents were slowest and I was most useful.

*Unofficial parody. Not affiliated with Rockstar Games or Take-Two Interactive. Company and person names are used for satire and are fictional in behaviour.*
