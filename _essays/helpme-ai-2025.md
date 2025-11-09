---
layout: post
title: "HelpMe AI"
date: 2025-09-27
description: "Building an Electron app at the Tomoro AI 'Chatbots are Dead. Build what's next' hackathon that provides in-the-moment visual guidance for computer tasks using voice input and screen analysis."
---

I spent my Saturday in London at the Tomorrow AI offices, for the [Chatbots Are Dead. Build What’s Next](https://luma.com/mru6gyzs) hackathon.

I built an Electron app for Mac OSX to provide in-the-moment help for people who are stuck on their computer.

Say you are on a product page and you're trying to figure out how to do something. The vision is to press a button, describe the issue you are facing, and then receive visual prompts to guide you to the correct buttons to click.

I decided to build a Mac app called Help Me that used application window screenshots, allowing it to run regardless of the application the user was using.


When you press a global hotkey, the application:
- Records the user's voice, transcribes it locally using Whisper
- Takes a screenshot of the current application window and passes it through Paddle OCR to obtain bounding boxes for all text content.
- Send all this to GPT-4o to obtain guidance and also returns the most relevant bounding box on their screen.
- That bounding text box is highlighted with a visual overlay.

I encountered several issues related to obtaining screen permissions and the resulting latency. All in all, it took about 10 seconds from describing your intent to getting a visual overlay. In an ideal world, the help that you would get would feel extremely real-time and detailed.

The other challenge was calculate where exactly the overlay should display on the user's screen. The coordinates of text using Paddle OCR were from the application window, but the overlay is drawn on the entire screen.

This meant the demo didn't work as effectively as I had wanted, because I was presenting on a larger screen than the one I had been testing on. 

Here's an example of the overlay I get when I ask where on the current screen I can manage my domain names.

Find the code [here](https://github.com/willgdjones/helpme).

<figure>
  <img src="/assets/images/HelpMe.jpeg" alt="HelpMe visual overlay">
  <figcaption>Where can I manage my domain names?</figcaption>
</figure>

Not quite as successful as I had hoped, but you can't win them all!
