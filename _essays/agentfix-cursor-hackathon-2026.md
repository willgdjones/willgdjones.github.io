---
layout: post
title: "AgentFix - AutoFix Your Errors with AI"
date: 2026-01-02
description: "I won the Build With Cursor hackathon with an AI-powered tool that automatically fixes errors in running programs."
---

In December, I joined the Build With Cursor hackathon at the Granola office, where Cursor released its new Cursor SDK.

It follows a similar vein to the Claude SDK, allowing you to read and write files on your file system with native TypeScript.

I spent a lot of time at the beginning of the hackathon really refining my ideas and figuring out what to work on. I wanted to explore something that would let AI fix live systems without you even needing to submit a PR. This would truly be putting a lot of trust in the AI, but as models have already been improving so dramatically in 2025, this was the direction software development is going. 

At some point, I imagined a system like a watcher, like nodemon, that automatically reloads a Node.js web server whenever changes are detected. Given that models are now so good at fixing issues, I imagined a program that wraps another program in a child process, monitors errors, and fixes them as they occur. That way, instead of running your program, encountering an error, trying to understand it with AI, and fixing it, the AI sees the error as soon as it happens and immediately attempts to fix it. The goal here is to really spend more time as a programmer in deep flow and on forward-looking tasks, rather than trying to fix existing annoying issues. The AI acts as a shield against all the annoying, repetitive, low-level cognitive work, allowing you to focus on vision.

Thus, the idea for `agentfix` was born. This optionally uses the Claude SDK or the Cursor SDK, depending on which API keys are set, and supports errors from a broad range of programming languages (Python, Ruby, Go, Rust, Java, PHP C#). Agentfix reads from stderr and uses the file system SDKs to modify the files to fix the errors it finds.

Try it for yourself by installing it globally from npm:

```bash
npm install -g agentfix
```

```
┌──────────────────────────────────────────────────────────────┐
│  Terminal                                                     │
│                                                              │
│  $ agentfix npm run dev                                       │
│                                                              │
│  🔧 AgentFix                                                  │
│  Starting: npm run dev                                       │
│  Using provider: Cursor                                      │
│  Monitoring for errors...                                    │
│                                                              │
│  Demo server running at http://localhost:3000                │
│                                                              │
│  TypeError: Cannot read properties of undefined              │
│    (reading 'toUpperCase')                                   │
│    at server.js:35:43                                       │
│                                                              │
│  [agentfix] 🔍 Error detected!                                │
│    Type: TypeError                                           │
│    Message: Cannot read properties of undefined             │
│      (reading 'toUpperCase')                                 │
│    File: server.js:35                                        │
│                                                              │
│  [agentfix] 🔧 Fixing...                                       │
│  I'll help you fix this TypeError. Let me first examine     │
│  the server.js file to understand the context around         │
│  line 35.                                                    │
│                                                              │
│  [agentfix] 🔧 read: Reading server.js                        │
│                                                              │
│  I can see the issue clearly. On line 35, there's a typo:    │
│  `u.nmee` should be `u.name`. The property `nmee` doesn't  │
│  exist on the user objects, so it returns `undefined`, and   │
│  calling `toUpperCase()` on `undefined` causes the          │
│  TypeError.                                                 │
│                                                              │
│  [agentfix] 🔧 edit: Editing server.js                       │
│  [agentfix] ✅ Modified: server.js                            │
│                                                              │
│  Restarting 'server.js'                                      │
│  Demo server running at http://localhost:3000                │
│                                                              │
│  The error has been fixed. The issue was a simple typo on   │
│  line 35 where `u.nmee` should have been `u.name`.          │
│                                                              │
│  [agentfix] ✅ Fixed server.js                                 │
│    Hot reload should kick in shortly...                      │
│                                                              │
│└──────────────────────────────────────────────────────────────┘
```

