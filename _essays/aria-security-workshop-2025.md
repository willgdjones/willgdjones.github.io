---
layout: post
title: "ARIA Security Workshop at Bletchley Park"
date: 2025-10-13
description: "Reflections on attending the ARIA Security Workshop at Bletchley Park, exploring the intersection of AI, robotics, and cryptography, and thoughts on verification, trust, and autonomy in robotic systems."
---

I spent a wonderful day on Monday at Bletchley Park. I was invited to attend the ARIA Security Workshop run by Alex Obadia and Nicola Greco, along with many others who did a fantastic job organising the sessions.

The discussion was under Chatham House rules, so I can't share the specifics, but I am wildly optimistic about ARIA's future. I am incredibly chuffed that these sorts of initiatives are happening in the UK, and that this is precisely where I want my taxpayers' money going.

In between walking through the exhibitions about the Enigma machines and watching physical computers read punch-cards and perform multiplications, I participated in optimistic, energy-filled discussions about the intersection of AI, robots and cryptography and how it will shape our future.

## Competing interests in data sharing

At Sano, we have wrestled with how best to manage competing interests when providing datasets used for our clients. On the one hand, there are widespread privacy concerns about how data is used in research. On the other hand, you have incredibly motivated patients of rare diseases who want to share their data as widely as possible to support research and increase the chances of finding a cure for their condition. On the research side, you have efforts to open-source large datasets and make them available widely. On the other hand, you have interests from pharmaceutical companies that have invested huge amounts into their proprietary datasets. They want to ensure they see a return on investment from it and hesitate to immediately share all of it with competitors in the industry.

There is a lot of promise, too. Tools like homomorphic encryption (HME) and multi-party computation (MPC) can guarantee privacy while enabling valid analyses. But a lot of these have not yet become widespread.

## Bold ambition and beginner's mindset

Hearing all these stories about ARIA pushing their fellows to be more ambitious and rejecting proposals that were not ambitious enough was inspiring, as was hearing the optimistic and energy-filled conversations about robotics, AI, cryptography and how exciting they will make the future. If it weren't for the Autumn-time British fog that covered us like a cotton blanket all day, I would have thought that I was in Silicon Valley. The day was filled with that bold, curious, beginner's mindset where you ask "why can't you?" rather than "why do you believe you can?" which is all too rare in the UK.

## Reflections on verification and trust

I had some lingering reflections on the drive home that I wanted to share about trusting sensors and data collected by robots, as well as the ability to verify a robot's behaviour deterministically, which may have already occurred to you and others during discussions, but on the off chance that they haven't, they could be helpful.

### Verification vs. autonomy

My first thought was to investigate whether or not there is a trade-off between the amount of verification we can expect and the autonomy we can grant. In a deterministic system with no autonomy, there are situations where we can achieve total verification, for example, with mathematical proofs of protocols and their behaviour in all possible situations. However, if we consider a robot interacting with an environment, it's impossible to expect us to verify its behaviour in the same way we might verify protocols. Even if we had a perfect world model to simulate trillions of possible futures in real-time at each minute iteration step, we would still ultimately have to expect the unexpected and have systems that can address that issue throughout society.

I was discussing with a group about potential solutions to this, for example, the idea of a possible future where one could purchase insurance against the behaviour of an agent or a robot, and if the agent acted in a way that was not consistent, you could make a claim against that, which follows some sort of dispute resolution process.

### Minimum viable trust

My second thought was how, at some level, we do need to trust the senses we receive. For example, we all trust our eyes to detect light ahead of us. And we all use that to build a world model inside our own heads so that we can make sense of reality. Indeed, sometimes our senses can deceive us, like how optical illusions take advantage of kinks in our optical recognition system. There is no way to truly verify this sense, just as it is difficult to imagine a world where we can verify that a sensor takes a reading. This leads me to conclude that we are all striving for a level of "Minimum Viable Trust" that is acceptable to use and prevents bad actors from abusing it. I think it echoes, in many ways, some of the motivations and thoughts behind cryptography itself that Nicola introduced during his presentation.

### Proof of deletion

Another question that emerged was: how do you verify that a system doesn't know your private credentials after you have shared it temporarily? A fundamental challenge in cryptographic systems—proving that data has been truly deleted and cannot be recovered. In scenarios where you need to temporarily share sensitive information with a system for processing, how can you be certain that the system has genuinely forgotten it afterwards? 

### Preventing the copy-paste problem

We also explored whether we can prevent the copy-paste problem—somehow relying on the quantum state of data to prevent reuse. This could potentially solve one of the fundamental challenges in digital data sharing: once data is shared, it can be copied infinitely. If we could encode information in a way that copying it destroys its quantum state or makes the copy detectable, we might have a mechanism to prevent unauthorized reuse while still allowing legitimate access.

## Looking forward

I really enjoyed the event and discussions and look forward to being with the community. I also connected with Claire Donoghue and plan to join her health workshop kickoff, which will take place in February.

