---
layout: post
title: "The Boggarts are coming"
date: 2026-02-07
description: "At a DeepMind/Granola hackathon, I built Boggart—an AI system that generates hyper-personalised adverts for major brands by deeply understanding who you are, what you want, and what you're afraid of."
draft: true
---

*This is the story behind Boggart, a system I built at a DeepMind/Granola hackathon on February 7th, 2025.*

In Harry Potter, a Boggart is a creature that looks into your mind and becomes whatever you fear most. Along with three other madmen crazy enough to spend their Saturday at a hackathon, I set out to build a digital Boggart.

The idea came from a simple, uncomfortable question: how personal could adverts be if an AI had access to your entire digital life? Not just what you've done—but who you are, what you want, what you're afraid of.

Boggart operates in two phases. First, it ingests your Google account. Your Gmail, Calendar, Photos, Drive, YouTube, and Contacts are used to build a psychological profile. Not a summary of activities, but an inference about your desires, fears, insecurities, and motivators. The profile is forensic. Uncomfortably accurate.

The system works on two layers: entities (structured from raw Google data) and a profile (derived by reasoning over entities). Raw data becomes Persons, Moments, and Artefacts. Then an agent reasons over this graph to produce a profile that captures your identity, relationships, psychology, interests, and communication style.

Once a profile exists, Phase 2 begins: content generation. You can ask Boggart to generate hyper-personalised content for any goal. "Sell me a laptop." "Convince me to go to the gym." "Scare me into backing up my data." For each request, it produces a strategy (why this angle will work on you), a visual concept, copy, and a video script.

The content should feel eerily personal. It should make you think "how did it know that would work on me?" That reaction is the entire point.

Boggart is a piece of art disguised as a tool. It's not here to sell you anything. It's here to show you how easily you could be sold to.

