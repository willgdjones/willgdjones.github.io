---
layout: post
title: "I Had 100 Missing Invoices. My AI Agent Found Them All."
date: 2026-02-21
description: "How I used an AI agent to track down 100 missing invoices across a dozen SaaS platforms and attach them to my accounting system, saving myself a full day of mind-numbing admin."
---

I had been putting off my bookkeeping for weeks.

Perihelion Limited is an AI consultancy I run. Like most small businesses, we use a dozen different SaaS tools - Replit, Cloudflare, AWS, Post Bridge, X, Amazon, Trainline, and more. Each one bills us monthly. Each one has its own billing portal, buried somewhere different in the settings. None of them offer bulk download.

I had about 100 purchase transactions in QuickFile with no receipts attached. My accountant needed them. HMRC could ask for them at any time. And I had genuinely decided that I would only deal with it if I got audited.

The maths was simple and depressing. Each invoice takes about 3-4 minutes to track down - log into the platform, find the billing section, locate the right month, download the PDF, go to QuickFile, find the matching transaction, upload it, tag it. Multiply that by 100 and you're looking at over 10 hours of mind-numbing admin. A full working day and then some, clicking through Stripe portals and billing dashboards.

I could not bring myself to do it.

Then I realised something. I already had an AI agent running on my laptop. I use OpenClaw - an open-source AI gateway that connects language models to your actual tools through Telegram. I have a finance agent that can access my browser, call APIs, read my emails, and interact with services on my behalf.

So I told it to sort out my invoices.

## What actually happened

The agent started by logging into each platform through my Chrome browser. Replit's billing goes through Stripe, so it navigated to the Stripe billing portal, found each monthly invoice, and downloaded the PDFs. Then it moved to Cloudflare, AWS, and the rest - each with their own portal, their own layout, their own way of hiding the billing page.

I watched it happen in real time. The browser was clicking through pages, opening invoices, downloading files. It felt like watching a very diligent accountant work through my mess at 10x speed.

Once the PDFs were downloaded, the agent used the QuickFile API to match each invoice to the right purchase transaction and attach it. This part was fast - once the API was set up, the matching and uploading was basically automated.

The browser automation wasn't perfect. Occasionally a page would load slowly or a button wouldn't respond. But these failures were rare, and when they happened, the agent would retry or ask me for a quick intervention. Maybe 5% of the time I had to nudge it along.

## The result

In a single session, the agent attached receipts to 42 of my 110 transactions. The Replit invoices alone covered 13 Stripe PDFs matched to 36 QuickFile entries spanning May 2025 through January 2026. It handled the fact that Replit's pricing had changed three times - from $7/month to $25 to $30 - without confusion.

There are still about 68 transactions to go, across providers like TopCoding, Trainline, and Amazon. But the system is set up now. Each new batch is faster than the last because the agent has learned where each provider keeps their invoices and how to navigate their portals.

## Why this matters

I am not unique. Every small business owner and freelancer I know has a version of this problem. A drawer full of unsorted receipts, a bookkeeping tool with gaps, and a vague dread about what happens when the taxman comes knocking.

The traditional options are: do it yourself (painful), hire a bookkeeper (expensive for what it is), or ignore it and hope for the best (risky). Most of us choose option three.

What changed for me is that AI agents can now reliably interact with real websites, real APIs, and real documents. This is not a chatbot summarising text. This is software that logs into Stripe, downloads a PDF, reads the amount and date, matches it to a bank transaction, and attaches it to the right record in your accounting system. Autonomously.

The setup was straightforward. QuickFile has a solid API. The browser automation runs through a Chrome extension. The whole thing is orchestrated through Telegram - I literally started the process by sending a message to my finance agent from my phone.

## The bigger picture

I was never going to do this work myself. I had accepted that. The invoices would have stayed missing until HMRC forced the issue, at which point I would have spent a panicked weekend doing exactly what the agent did in an afternoon.

This is the promise of AI that I find most compelling - not replacing creative work or making decisions for you, but handling the admin that you have already given up on. The stuff that sits on your to-do list for months, that you know you should do but cannot face. The boring, repetitive, clicking-through-portals work that no human should have to spend their Saturday doing.

If you run a small business and you have been putting off your bookkeeping, the tools exist now to make it painless. Not perfect, not fully autonomous, but good enough that the work actually gets done instead of being indefinitely postponed.

That feels like a genuine step forward.

If you are dealing with the same problem and want to know more about how I set this up, get in touch - williamgdjones[at]gmail.com.
