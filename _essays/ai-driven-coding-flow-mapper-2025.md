---
layout: post
title: "On AI-Driven Coding"
date: 2025-06-16
description: "How I used Cursor and Claude 4 Sonnet to build a Flow Mapper canvas at Sano, and what it taught me about the practice of AI-driven coding."
---

A fundamental part of what we do at Sano is help participants find the right clinical trial for their condition. This involves navigating a sequence of questions in a "Flow" to determine their eligibility. We had an internal "Flow Builder" tool, but it always felt limited because it did not display the paths a participant could jump to based on their answers, and could never prioritise improving it.

Over the period of about a week, and another week of code review, I used Cursor and Claude 4 Sonnet to develop a canvas layer for this Flow Builder, which we are calling the Flow Mapper. This layer leverages the structure of a related canvas tool, the Study Mapper, that already existed in the codebase.

This turned out to be a resounding success, and it has now been deployed to production 🎉.

<div style="display: flex; gap: 16px; margin: 32px 0;">
  <div style="flex: 1; text-align: center;">
    <img src="/assets/images/FlowMapper.jpg" alt="The new Flow Mapper — a canvas view showing sections connected by paths" style="width: 100%; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);" />
    <p><em>The new Flow Mapper</em></p>
  </div>
  <div style="flex: 1; text-align: center;">
    <img src="/assets/images/FlowBuilder.jpg" alt="The old Flow Builder — a linear list view of questions" style="width: 100%; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);" />
    <p><em>The old Flow Builder</em></p>
  </div>
</div>

There are a few principles that I've pulled from this experience of AI-driven coding that I wanted to share, because it fundamentally changed how I think about the practice of creating software:

- **Engineers will spend significantly more time reviewing code than writing it.** It is our responsibility only to include code within Pull Requests (PRs) if it has been reviewed and understood by us as Engineers. We should be able to explain how any piece of the code works if asked for clarification. As Ismail Mohammed, an Engineer in our team, put it: *"Thou shalt not ask someone to review AI code that you have not reviewed yourself."*

- **The speed and cost of Continuous Integration suites (CI) will become more of a bottleneck**, and optimising both time and cost of this will become increasingly important going forward.

- **The more I understood the implementation that was generated, the better I was able to guide the next iteration.** I found myself stripping out bits of technical debt at each generation, much like a gardener removing weeds. For me, this is what differentiates AI-driven Coding from Vibe Coding. It got stuck several times, and I had to resort to reading and thoroughly understanding the generated code to identify the problem. As soon as I suggested the problem, the AI fixed it immediately. Therefore, I remain convinced that engineering judgment and understanding of the code will remain crucially important.

This experiment only worked as well as it did because we had many reusable components that were well-built (shout out to our amazing Frontend team). It required refinement via code review to improve code quality and to address edge cases (h/t Jack Callow).

However, I do not think it's controversial to say that AI has changed the game.

It is still early days in the Golden Age. Go and build something great!

*If you're building software in this way and are excited about what we're doing at Sano, I'd love to meet and collaborate with you!*
