---
layout: post
title: "ARIA Extending Our Perception Workshop"
date: 2026-02-10
description: "Reflections after attending the ARIA Extending Our Perception workshop, exploring a future where intelligence is too cheap to meter and sensors become the limiting factor in health optimization and AI-driven wellness."
---

On February 10th, I attended the ARIA Extending Our Perception workshop, where conversations centred around a profound shift in our technological landscape: we are moving toward a world where intelligence is too cheap to meter. This isn't just about cheaper compute, it is about a fundamental reordering of what becomes valuable, what becomes scarce, and what becomes possible.

## Intelligence too cheap to meter

The core thesis of the workshop was that as intelligence becomes increasingly cheap and abundant, the limiting factor shifts from computation to data. We're entering an era where AI agents will be able to process vast amounts of information at negligible cost, but they'll be constrained by the availability and quality of sensor data.

This has profound implications for health and wellness. We're seeing an increasing number of people who are electively self-monitoring with all available sensor data. These individuals aren't just passively wearing fitness trackers—they're actively collecting comprehensive data streams about their physiology, behavior, and environment. And increasingly, we're going to have AIs that proactively manage us, serving as performance coaches that nudge us toward improving our quality-adjusted life years (QALY) scores.

In this world, relevant data becomes the limiting factor. The question isn't "can we afford to analyse this data?" but rather "do we have the right sensors capturing the right information?"

## A marketplace for sensors

One idea that emerged during discussions was the possibility of a future marketplace for sensors. Imagine an AI agent query service where you could request temperature readings or air pollution data for a specific location, paying a micropayment for access. This could be economically valuable to someone conducting deep research queries and aggregating data in novel ways.

The economic model here is fascinating: as intelligence becomes cheap, the economic buyers are increasingly going to be AI agents themselves. These agents will need sensor data to make decisions, and they'll be willing to pay for access to high-quality, real-time sensor streams. Could we find a way to make sensors economically profitable to run and connect to a network? What sensors can we provide that offer immediate economic value?

This isn't just theoretical. If AI agents become the primary consumers of sensor data, we need to design economic incentives that make sensor deployment and maintenance profitable. The sensor marketplace could become a critical infrastructure layer for AI-driven applications.

## OpenCLAW and personal data integration

The workshop also sparked ideas about systems like OpenCLAW—open-source AI agents that could be given comprehensive access to your health, background, life data, genetics, goals, and more. This motivated me to think about what a blog post might look like: "I gave OpenCLAW access to my genetic data—here is what happened."

The vision extends beyond personal health data. Could OpenCLAW be set up to have complete control over everything in your household? A 3D printer, all the Philips Hue lights, complete home automation—all managed by a local intelligence hub running on something like an M3 Mac Mini with Kimi K2. You could text commands like "Turn off all the lights" or "Print this thing." You could optimize your weekly online shop with OpenCLAW managing everything proactively.

Even more ambitiously, could OpenCLAW proactively monitor your Oura data, your NHS data, your blood glucose level, and combine that with your genetic data? The idea of an AI agent that has complete visibility into your health and lifestyle, continuously optimizing and nudging you toward better outcomes, is both exciting and slightly uncomfortable.

This vision requires local intelligence: you really need an intelligence hub running locally to maintain privacy and control. The idea came to me to potentially set up an open-close service in London and Cambridge: come with a Mac Mini to your house and set everything up. A turnkey solution for personal AI infrastructure.

## Three research breakthroughs

The workshop identified three key research breakthroughs needed to realize this vision:

### Breakthrough 1: Complete data collection

The first breakthrough focuses on developing non-invasive sensor streams that don't require user compliance. The goal is automatic data capture without user intervention. Smart glasses were mentioned as a potential solution for objective action tracking, providing a continuous stream of what you're actually doing rather than what you remember doing. An alternative approach could be comprehensive Android phone monitoring for behaviour tracking.

The challenge here is that most current sensor systems require active user engagement: remembering to wear a device, charging it, syncing data. True breakthrough requires passive, frictionless data collection that happens automatically in the background.

### Breakthrough 2: Predictive digital twins

The second breakthrough needs to prove that novel non-invasive sensor streams actually improve predictive accuracy. It's not enough to collect more data—we need to find data streams with actual predictive power beyond existing methods.

This requires rigorous validation through ablation studies. For example, if we remove coffee drinking actions from the model, does the sensor data still provide predictive value? We need to establish gold standard metrics for prediction validation and demonstrate that new sensor streams add genuine insight rather than just noise.

### Breakthrough 3: Real-time wellness interventions

The third breakthrough involves deploying interventions that actually modify behaviors using digital twin predictions. Imagine receiving a text message suggesting "don't drink coffee" based on simulation results from your digital twin. The system would measure compliance and actual health outcome improvements, validating through back-testing before real-world deployment.

This is where the rubber meets the road. Can we move from prediction to intervention? Can we prove that these interventions actually improve health outcomes?

## Success metrics and early signals

The workshop identified clear success indicators:
- High user adoption and compliance rates
- Complete, high-quality data collection
- Predictive accuracy beyond autoregressive baselines
- Effective behavioral intervention outcomes

And equally important failure indicators:
- Inability to predict even basic autoregressive patterns
- Poor data completeness or quality
- Low user compliance with data collection
- Hardware failures preventing data capture

## Technical implementation challenges

The biggest challenge identified was the data labeling problem: connecting sensor data to actual behaviors and lifestyle context. We need comprehensive metadata labeling of what activities correspond to sensor readings. This requires objective validation—finding ways to verify user actions without relying on self-reporting, which is notoriously unreliable.

Success depends on low-friction, passive data gathering methods. If users have to actively engage with the system, compliance will drop and data quality will suffer.

## Looking forward

The workshop left me energized. We are at an inflection point where intelligence is becoming a commodity, and the real value will be in the data we can collect and the insights we can derive from it. The vision of AI agents proactively managing our health, optimizing our environments, and serving as performance coaches is no longer science fiction—it's becoming technically feasible.

As intelligence becomes too cheap to meter, the question shifts from "can we afford to think about this?" to "do we have the right data to think about this?" And that's a fundamentally different problem. One that requires us to rethink how we collect, share, and monetize sensor data in an AI-driven world.


