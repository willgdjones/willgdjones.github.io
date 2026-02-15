---
layout: post
title: "VoiceBuilder: Conversation-Based Creation in MindEye at the xAI Grokathon"
date: 2026-01-17
description: "At the Grokathon hackathon at xAI offices, I built VoiceBuilder within MindsEye: an AI agent that enables conversation-based creation in Build.Arcadia using Grok's Voice Agent API, bringing us closer to a future where AI serves as a co-creation partner in gaming."
---

Last Saturday, I went to the Grokathon at the xAI offices.

Since the beginning of the year, I have been doing some consulting work with my good friend Mark, who runs the game studio Build a Rocket Boy (BARB) on the launch of their game, Mindseye. This is a third-person open-world shooter game. Mark and I share the vision that the future of gaming will integrate real-time AI to offer a whole new entertainment experience. This AI would be kind of like your co-pilot, or co-creation partner, or maybe even your companion who accompanies you as you complete missions.

Within Mindseye, there is a rich suite of tools with which to build your own open worlds and even missions called Build Arcadia. You can literally create your own missions, levels, and environments using no-code tools and then play them! Imagine playing your favourite scene from Harry Potter, Die Hard, or The Matrix. You are literally limited only by your imagination.

The challenge is that the suite of tools is so powerful that it's almost like learning another language to know how to use them to bring what you want to life. This is really the potential that I see AI having as a co-creation partner. What if, instead of having to learn the tools yourself, you could describe what you want, and then an AI could carry that out for you? Basically vibe-building games.

## VoiceBuilder Agent

The goal of VoiceBuilder is to make it easier to create within the Mindseye Build Arcadia environment. Build Arcadia offers Mindslayer the ability to create their own worlds using a wide variety of pre-built assets (such as walls, sofas, and buildings) and existing collections of assets called stamps.

To beginners, the comprehensive suite of tools can seem overwhelming: the logic, the assets, the tools. The tools are there to create powerful, personal experiences that people will really enjoy playing with, but the barrier to entry is very high. It's almost as high as game development itself.

This means that, until now, only professional curators paid by Mindseye have used the tools to create content.

The goal is to use Voice AI, specifically Grok's Voice Agent API over websockets, to enable 'conversation-based creation'. You talk to an AI about what you want to build in the world, like spawning buildings, objects, and building structures, and the AI would go about building it for you in front of your eyes.

## Learning the Gaming Industry

My experience transitioning into the world of high-performance gaming was eye-opening. There was a lot of new concepts for me to learn. One of the wildest things that I had to get used to was that the code repository is 350 GB! There is a specialized version control system used in the gaming industry called Perforce which allows syncing repositories of this size effectively using a different version control for remote than Git or SCM.

Working with this scale of codebase and infrastructure was a reminder of just how different game development is from web development. The assets, the engine, the tooling—everything operates at a different scale. But it also reinforced my belief that AI could be the bridge that makes these powerful tools accessible to more people.

## The Hackathon Experience

I didn't win, unfortunately, but I got a lot of excitement from people who walked behind me, curious about what I was doing with a high-performance gaming laptop with 64 GB RAM, an i9 processor, and a GeForce RTX 4090 GPU. That enthusiasm validated the vision of a real-time, conversation-based creation experience.

There's something compelling about watching someone talk to an AI and see their ideas materialize in a game world in real-time. It's the kind of demo that makes people stop and think about what's possible. The hardware requirements might be high now, but that's often how transformative technologies start—demanding, expensive, and then gradually becoming more accessible.

I plan to continue refining the Voice Agent integration, and here's the [video I recorded as my hackathon submission](https://www.loom.com/share/1196f8450c054ab1964da7c97c1595cd).

The vision of conversation-based creation in gaming is still in its early stages, but hackathons like Grokathon are exactly the kind of spaces where these ideas can be tested and refined. The future of gaming won't just be about better graphics or more realistic physics—it will be about lowering the barriers to creation and letting more people bring their imaginations to life.

