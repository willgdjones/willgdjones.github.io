---
layout: post
title: "DocTweak: Embedding AI in Google Docs"
date: 2025-02-01
---

DocTweak is a tool that integrates AI assistance into Google Docs. It enables dynamic content editing right where you write, rather than constantly copying and pasting content into ChatGPT.

<figure>
  <img src="/assets/images/DocTweak-v0.1.gif" alt="DocTweak interface showing AI suggestions in Google Docs">
  <figcaption>DocTweak in action: AI-powered suggestions directly in Google Docs</figcaption>
</figure>

While seemingly a "GPT wrapper", embedding AI naturally into existing workflows can help users discover AI's applicability to their situational needs.

I wanted the ability to easily and dynamically edit content in a Google Doc with AI. I hate having to constantly and posting content into ChatGPT. Instead, I want to clarify, critique, and summarise my writing without disrupting my creative flow. This brings applications closer to their natural context rather than bringing users away from it, for example, into a brand new application. Shoutout to the [Lex.ai](https://lex.ai) team who are trying to build a fully fledged Cursor for Writing experience.

Here's how DocTweak works:

1. Highlight text within your Google Doc
2. Submit a prompt about how you want to edit or improve it
3. An AI response replaces the highlighted text

Originally, I wanted to use the Google Docs Suggestion feature for this. However, after [researching online](https://stackoverflow.com/questions/60775916/google-docs-api-edit-text-as-suggestion), I found that this feature is unfortunately still not yet available.

There is a lot of potential for subtly embedding AI into existing apps and workflows. These apps can actually bring value to many people who would not otherwise know that AI could help them in their particular situation.


There are two modes in DocTweak: Critique and Replace.

### Critique Mode
Sometimes you don't want direct changes - you want feedback. Maybe you're wondering if a paragraph is clear enough, or if your tone is appropriate for your audience. Critique mode is designed for these moments. Simply select your text, ask your question, and get focused, actionable feedback without any automatic changes to your document.

<figure>
  <img src="/assets/images/DocTweak-v0.2Critique.gif" alt="DocTweak Critique Mode">
  <figcaption>DocTweak Critique Mode</figcaption>
</figure>

### Replace Mode
When you're ready for concrete improvements, Replace mode is your go-to option. It provides AI-suggested rewrites of your selected text, with a clear preview and the control to apply changes when you're satisfied with the suggestion.

<figure>
  <img src="/assets/images/DocTweak-v0.2Replace.gif" alt="DocTweak Replace Mode">
  <figcaption>DocTweak Replace Mode</figcaption>
</figure>



