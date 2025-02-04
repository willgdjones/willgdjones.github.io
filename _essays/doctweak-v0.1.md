---
layout: post
title: "DocTweak v0.1: Embedding AI in Google Docs"
date: 2025-02-01
---

DocTweak v0.1 is a tool that integrates AI assistance into Google Docs. It enables dynamic content editing right where you write, rather than constantly copying and pasting content into ChatGPT.

<figure>
  <img src="/assets/images/DocTweak-v0.1.gif" alt="DocTweak interface showing AI suggestions in Google Docs">
  <figcaption>DocTweak in action: AI-powered suggestions directly in Google Docs</figcaption>
</figure>

While seemingly a "GPT wrapper", embedding AI naturally into existing workflows can help users discover AI's applicability to their situational needs.

I wanted the ability to easily and dynamically edit content in a Google Doc with AI. I hating having to constantly and posting content into ChatGPT. Instead, I wanted to clarify, critique, and summarise my writing without disrupting my creative flow. This brings applications closer to their natural context rather than bringing users away from it, for example, into a brand new application. Shoutout to the [Lex.ai](https://lex.ai) team who are trying to build a fully fledged Cursor for Writing experience.

Here's how DocTweak works:

1. Highlight text within your Google Doc
2. Submit a prompt about how you want to edit or improve it
3. An AI response replaces the highlighted text

Originally, I wanted to use the Google Docs Suggestion feature for this. However, after [researching online](https://stackoverflow.com/questions/60775916/google-docs-api-edit-text-as-suggestion), I found that this feature is unfortunately still not yet available.

There is a lot of potential for subtly embedding AI into existing apps and workflows. These apps can actually bring value to many people who would not otherwise know that AI could help them in their particular situation.

You can read more about DocTweak v0.1 [here](https://github.com/willgdjones/doctweak/releases/tag/v0.1).
