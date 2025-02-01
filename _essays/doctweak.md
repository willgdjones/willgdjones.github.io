---
layout: post
title: "DocTweak: Embedding AI in Google Docs"
date: 2025-02-01
---

DocTweak is a tool I built to seamlessly integrate AI assistance directly within Google Docs. Rather than constantly switching between documents and ChatGPT, it enables dynamic content editing right where you write.

<figure>
  <img src="/assets/images/DocTweak.gif" alt="DocTweak interface showing AI suggestions in Google Docs">
  <figcaption>DocTweak in action: AI-powered suggestions directly in Google Docs</figcaption>
</figure>

<span class="sidenote">
While seemingly a "GPT wrapper", embedding AI naturally into existing workflows can help users discover AI's applicability to their specific needs.
</span>

I wanted to easily and dynamically edit content with AI in a Google Doc. I wanted to clarify, critique, and summarise my writing without continually blasting content into ChatGPT. This brings applications closer to the context rather than bringing users away from their original context (e.g., into a new application).

DocTweak allows you to highlight text within your Google Doc, submit a prompt about how you want to edit or improve it and replace the highlighted content with the AI response.

Originally, I wanted to use the Google Docs Suggestion feature for this. However, after [researching online](https://stackoverflow.com/questions/60775916/google-docs-api-edit-text-as-suggestion), I found that this feature is unfortunately still not yet available.

I still find this interface fascinating. And there is a lot of potential for subtly embedding AI into existing apps and workflows. Despite the fact that this is merely a “GPT wrapper”, my intuition is that this could actually bring a lot of value to a lot of people who would not otherwise make the connection that AI could be applicable in their precise situation. 
