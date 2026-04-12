---
layout: post
title: "I Let my F-AI-nance agent Do My Accounts"
date: 2026-04-12
description: "A single Claude Code session reconciled two months of business accounts, matched receipts from Gmail and Apple Photos, and uploaded everything to Xero."
---

Last night I sat down to do my company accounts for Perihelion Limited, my UK software consultancy. I had fallen behind. Two months of Monzo business transactions were sitting unreconciled in Xero. 68 bank statement lines were waiting to be matched. Invoices were scattered across Gmail, Apple Photos, and my Downloads folder. The kind of tedious, fiddly admin work that I, like many others, procrastinate on for weeks, then pay an accountant hundreds of pounds to sort out.

Instead I had an idea. I opened Claude Code and said: "I'm on Xero and Monzo, here's my client ID and secrets. Sort it all out"

What happened next took a few hours of back-and-forth, but the work that got done would have taken me days, and would have cost me several hundred pounds if I'd handed it to my accountant.

I called this my fainance agent.

## What the agent actually did

Here's the concrete output from a single session:

**I connected to three separate services via OAuth:**
- Xero (accounting software) — OAuth 2.0 code flow with the new granular scopes
- Monzo (business bank) — API playground token
- Gmail — via Google Workspace CLI with full attachment download capability

**It pulled and reconciled 88 bank transactions** from the Monzo API, matched them against the Xero bank feed, and created categorised bank transactions for every single one. It figured out the expense account mappings (IT Software for SaaS subscriptions, Travel for Trainline and Uber, Entertainment for restaurants, Rent for my office). The Xero balance matched the Monzo statement balance to the penny.

**It created and managed 6 sales invoices and a credit note** for my client Build A Rocket Boy, handling a complex re-invoicing situation where two monthly invoices needed to be credited and re-issued with VAT, plus a large milestone delivery invoice. It tracked the payments, allocated the credit note, and ensured everything balanced.

**It hunted down 60 receipts** from three different sources and attached them to the corresponding transactions in both Xero and Monzo:

- **11 PDF invoices** downloaded directly from Gmail attachments (Stripe receipts from Anthropic, Replit, Cluely, Cloudflare, Railway, Resend, Excalidraw, xAI, Airalo)
- **12 receipt photos** found by querying my Apple Photos SQLite database, searching for "receipt 2026", exporting them via AppleScript, then visually reading each image to match it to a transaction
- **17 HTML email receipts** from Trainline, Uber, Veezu, Lime, X Developer Platform, and AWS — converted to PDF using WeasyPrint and uploaded
- **6 local PDF invoices** I'd already downloaded (Build A Rocket Boy contracts, Grammarly)
- All 35 receipts also uploaded to the corresponding Monzo transactions via the Monzo Attachments API

## What strikes me about this

I've been building AI tools for years. I've written about agents, built agent frameworks, won hackathons with agent demos. But this session felt different. This wasn't a demo. This was real, messy, boring admin work — the kind that involves juggling multiple authenticated services, understanding UK VAT rules, reading crumpled receipt photos, and making judgment calls about expense categorisation.

The agent didn't just follow a script. It:

- **Diagnosed and fixed its own mistakes.** When invoice payments double-counted income in Xero (because creating a payment auto-generates a bank transaction), it identified the discrepancy from the reconciliation report, understood the root cause, and deleted the duplicates.
- **Adapted to constraints.** When the Xero `bankfeeds` scope turned out to be restricted to regulated financial institutions, it pivoted to pulling transactions directly from the Monzo API instead.
- **Read physical receipts.** It queried my Apple Photos library, found receipt images using Apple's on-device OCR search, exported them, looked at each photo, read the vendor name and amount, and matched them to the right bank transaction. A photo of a crumpled till receipt from The Side Quest pub in Little Shelford, matched to a £67.12 Monzo card payment, uploaded to Xero with the correct expense category.
- **Navigated bureaucracy.** Xero's new granular scopes (introduced March 2026) meant the old scope strings didn't work. The agent read the documentation I pasted, identified the correct new scopes, and iterated until the OAuth flow worked.

## The economics

My accountant charges around £150/hour for bookkeeping work. Two months of transaction categorisation, receipt matching, and invoice management would be at least 3-4 hours of their time — call it £500.

This Claude Code session cost me maybe £20 in API usage. The work is done, the books balance, and every transaction has a receipt attached. My accountant can review it, but the grunt work is finished.

More importantly: the time I would have spent doing this myself — downloading PDFs, logging into Xero, clicking through reconciliation screens, manually uploading receipt photos one by one — is time I can never get back. The agent did it while I answered questions and pasted OAuth credentials.

## What this means

We're at the point where an AI agent can sit in a terminal, authenticate to your business services, pull data from multiple APIs, cross-reference it, make reasonable categorisation decisions, find supporting documents across email and photo libraries, and upload everything to the right place.

This isn't theoretical. This isn't a demo with fake data. This is my actual company's books for February, March, and April 2026, now fully reconciled and documented in Xero.

The grungy admin work that humans used to have to do — that you used to have to pay accountants to do — is becoming something you can delegate to an agent in a conversation. Not perfectly, not without oversight, not without the occasional mistake that needs correcting. But the heavy lifting, the tedious cross-referencing, the downloading and uploading and categorising — that's done.

I still need an accountant for tax strategy, compliance advice, and year-end submissions. But the bookkeeping? The receipt matching? The bank reconciliation? That's agent work now.

It makes it hard to think about building applications at all. Maybe just give Claude Code the API keys and let it do it?
