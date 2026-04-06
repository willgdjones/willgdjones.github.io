---
layout: post
title: "MailToll - The Toll Booth for Your Email"
date: 2026-04-04
description: "Email has no cost signal separating genuine intent from noise. MailToll adds a priced fast lane to your inbox — and pays you for your attention."
draft: true
---

Email was supposed to be a communication tool. Instead, it became a dumping ground — a place where anyone, with zero cost and zero accountability, can demand your attention indefinitely.

The result? The average professional spends 2.5 hours a day on email. Most of it noise. Most of it unrequested. And the tools we've built to manage it — filters, unsubscribe buttons, spam folders — are arms-race solutions that barely keep pace with the volume.

There's a better way. And it starts with asking a simple question: what if your attention had a price?

---

## The Problem With Free Email

When something costs nothing, people abuse it. Email is free to send, so people send billions of them. Cold outreach, sales sequences, newsletters you never signed up for — all of it lands in the same inbox as messages from people who actually matter to you.

The problem isn't the technology. It's the economics. There is no cost signal that separates genuine intent from noise. A recruiter with a life-changing opportunity pays exactly the same as a spammer blasting a million addresses: zero.

This is the problem MailToll solves.

---

## What Is MailToll?

MailToll is a priority inbox protocol. It lets anyone send you a guaranteed-delivery, high-priority message — but they have to pay a small fee to do it. That fee goes directly to you.

You keep your existing email address. You keep Gmail. Nothing changes about how you receive normal mail. MailToll simply adds a fast lane on top — a public endpoint that anyone can use to reach you with certainty, if they're willing to put a little money behind it.

Your MailToll endpoint looks like this: `mailtoll.app/yourname`

Any sender — human or AI agent — can visit that endpoint, pay a micropayment, and send you a message that lands in your inbox with a dedicated priority Gmail label, guaranteed. No spam filters. No algorithmic triage. Just a direct line to your attention, priced appropriately.

---

## Why the Money Goes to You

This is the part that makes MailToll different from every other "inbox management" tool that's come before it.

The fee doesn't go to the platform. It goes to you, the recipient.

That changes everything. Suddenly your inbox isn't a liability — it's an asset. High-value people who get a lot of inbound interest earn more, because senders are willing to pay more to reach them. The price signal is honest: if someone is willing to pay £2 to get your attention, that message is probably worth reading.

And spam? Spam becomes revenue. Which means you stop dreading it.

---

## Built for the Age of AI Agents

Here's what makes MailToll genuinely timely: the rise of GTM agents.

Right now, AI-powered go-to-market tools are being deployed at scale. Agents that research targets, craft personalised outreach, and attempt to initiate contact — all programmatically, all autonomously. These agents are getting better at identifying the right people to reach. But they have no reliable channel to actually reach them.

Email deliverability is a black hole. LinkedIn is rate-limited and noisy. There's no machine-readable signal that tells an agent: "this person accepts cold contact, under these conditions, at this price."

MailToll is that signal.

Your MailToll endpoint is machine-readable by design. A GTM agent can query `mailtoll.app/yourname`, discover your pricing and preferences, execute a micropayment programmatically — via Stripe, Coinbase, stablecoins, or x402 — and deliver a message that's guaranteed to reach you. The entire flow, from discovery to delivery, requires no human in the loop on the sender side.

x402 is the HTTP 402-based payment protocol built jointly by Coinbase and Stripe, now live on the Base network. It allows an AI agent to discover a price, pay in USDC on-chain, and proceed — all in a single programmatic loop. No account creation. No OAuth dance. Just an HTTP request with a payment attached. MailToll is one of the first inbox-layer services to support it.

MailToll is, in essence, the DNS layer for agent-to-human contact. A registry of human endpoints that the agentic economy can reliably route through.

---

## How It Works

**For recipients:**

1. Sign in with Google
2. Grant Gmail permissions
3. Get your public endpoint: `mailtoll.app/yourname`
4. Set your price, preferred categories, and whitelist trusted contacts

That's it. Whitelisted senders — friends, colleagues, existing contacts — reach you for free as always. Everyone else goes through the toll.

**For senders (including AI agents):**

1. Query the recipient's endpoint to discover pricing
2. Pay via your preferred rail
3. Submit your message
4. It arrives in the recipient's inbox with a priority label, guaranteed

No account required. No platform lock-in. Just a clean, programmable interface for reaching humans who've opted in.

---

## The Bigger Picture

What we're really building is a market for attention.

Attention is the scarcest resource in the modern economy. Everyone wants it. Nobody has built a proper price discovery mechanism for it — until now. MailToll does for human attention what Airbnb did for spare rooms: creates a market where none existed, and lets the people who have the asset decide what it's worth.

The payment isn't just a revenue mechanism. It's a trust signal. It tells you, before you read a single word, that the sender thought this message was worth something. That changes how you read it.

In a world increasingly mediated by AI agents — where more and more outreach is automated, personalised, and programmatic — MailToll gives humans back control of their own inbox. You decide who can reach you. You decide what it costs. And you get paid for your time.

---

## Try It

MailToll is live. Connect your Gmail, set your price, and share your endpoint. If you get a lot of inbound — as a founder, investor, creator, or domain expert — start getting paid for the attention you're already giving away for free.

If you're building a GTM agent and want a reliable, machine-readable channel to reach humans who've opted in, MailToll is the cleanest path. Query the endpoint, pay the toll, deliver the message. No account required.

The inbox is broken. We're fixing it with economics.

**→ mailtoll.app**
