---
layout: post
title: Learning 5,000 French Words, One Ninja at a Time
date: '2026-10-21'
description: My seven-year-old started at a French school missing the basic vocabulary. So I had AI agents build him a Ninjago game that teaches the first 5,000 words, in the order French schools teach them.
---

Since we moved, my seven-year-old has started at a French school. He reads reasonably well, in English and in French, but he's missing the basic vocabulary that his classmates picked up as toddlers. Flashcards were never going to survive contact with him. Ninjago was.

So I built him a game. Or rather, I wrote the brief, and AI agents built it in four days.

**Play it: [ninjago-french.pages.dev](https://ninjago-french.pages.dev)** · [code](https://github.com/willgdjones/ninjago-french)

![Ninjago : Les Vagues des Mots title screen](/assets/images/obsidian/ninjago-french-2026/title.png)

## How it plays

Kai fights from the left, a villain from the right. Every turn is one French prompt: hear a word and tap its picture, read a picture and pick the French, fill the gap in a sentence, spell the word letter by letter, or do the action you're told ("saute!"). Get it right and that word's own picture flies across the screen at the villain. Get it wrong and the game says the right answer out loud, and the word comes back a couple of turns later.

![A correct answer throws the word's picture](/assets/images/obsidian/ninjago-french-2026/attack.png)

Underneath, it's a proper course: about 5,000 words in the order French schools teach them, cut into 100 stages of 50. New words show their English until he's answered them correctly twice on his own. The story subtitles drop their English after 300 mastered words. There's a parent page behind a three-second hold, so I can see what he's learned without him seeing a "progress report".

## The code was the easy part

The hard part was the content. A word list is not a curriculum, and the first version proved it: stage one started with *faire, se, nous, on, me, y*. Those are the most frequent words in French, and completely impossible to draw. A game that runs on pictures can't open with "y".

So the early stages were rebuilt "concrete first": things you can picture come first (stage one now opens with words like *maison, main, mer*), with the little grammar words arriving in groups (*pour, par, sur, avec, sans*) so they can be practised against each other.

Then a language model critiqued every one of the 5,000 entries. It found 1,461 synonym problems (two right answers on the same screen), 416 picture problems and 349 wrong meanings. The pictures come from ARASAAC, a wonderful free pictogram library, plus generated ones for the gaps. Of the 153 generated pictures, a stricter audit threw out 100, using one rule that I'd now apply to any educational picture: **reject it if a child would first name a different word in the course.**

Every word, sentence and story line has a recorded French voice, about 10,000 clips in all. Getting audio to play reliably on an iPad in Safari, including with the silent switch on, was its own small saga.

## The playtest that changed the game

My son's verdict on an early version: attacking with a random word "is not useful or interesting".

He was completely right. Picking a word card and watching it fly asked nothing of his French. So the game changed: turns alternate, every action needs French, and the projectile is the picture of the word you just got right. It sounds like a small change, but it's the difference between a game with French in it and a French game.

![Every turn is one French prompt](/assets/images/obsidian/ninjago-french-2026/battle.png)

## What I learned

**Content quality is the product.** The agents could build the engine in a day. The time went on making sure 5,000 words, pictures, sentences and voices were truthful, unambiguous and in the right order.

**Kids give the best design reviews.** Nobody else would have told me so bluntly that the core mechanic was boring.

**Make the rule explicit.** "Reject the picture if a child would name a different word" turned a vague quality bar into something an AI reviewer could apply 5,000 times.

It's an unofficial, non-commercial fan project (Ninjago belongs to LEGO, and the pictograms are CC BY-NC-SA). The code is MIT.
