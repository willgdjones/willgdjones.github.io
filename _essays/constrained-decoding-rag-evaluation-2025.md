---
layout: post
title: "Constrained Decoding and RAG Evaluation"
date: 2025-12-02
description: "Exploring how structured outputs work under the hood through constrained decoding, and how to properly evaluate RAG systems for reliable information retrieval across PDF documents."
---

As part of some recent interviews, I was asked questions I couldn't answer, so I decided to do some follow-up research to broaden my understanding of LLMs.

## Constrained Decoding

One question that I was asked was how structured outputs actually worked under the hood. I had previously thought this was purely a retry mechanism, but in fact, the output tokens are actively restricted to ensure the response is valid via a process called constrained decoding.

### How does constrained decoding work?

During inference, the model's raw outputs (logits) are converted to a probability distribution using the softmax function. The next token is then sampled from this distribution. With constrained decoding, a schema-derived grammar processes partial outputs and determines which tokens are valid continuations in real time, masking out invalid tokens by setting their logits to negative infinity so that sampling effectively occurs from a restricted distribution.

### How does this schema-derived grammar actually determine valid next tokens?

For each output prefix, a parse state is generated to track information like: are we inside a `{ }` or a `[ ]`, are we expecting a key/colon/value, which required fields have we seen, are we inside a string, if we are inside an enum, which enum values are still viable etc… The grammar operates at the character level, while the model outputs tokens. Therefore, the grammar restricts valid tokens to those whose string decodings keep the generated prefix on at least one grammar path. The grammar takes the form of an incremental recogniser that, before generating a given next token, simulates adding all tokens in the vocabulary and determines the validity of the hypothetical next token according to the grammar. The grammar itself comprises a deterministic finite automaton (DFA), a stack to keep track of nesting, and additional components for schema constraints such as fields and enums.

## RAG System Evaluation

The other question I was asked, and for which I wasn't satisfied with my answer at the time, was how to evaluate a RAG system that reliably retrieves information across a set of PDF documents. 

Ultimately, the key here is that you need a handcrafted eval set of queries and intended PDFs/chunks to be retrieved, for which you:

1. Evaluate whether or not the correct PDF is selected
2. Evaluate whether or not the correct chunk within that PDF is selected

Then you can measure recall@k to understand if the most relevant chunks appear in the top k results, and precision@k to know how many of the top k chunks are actually relevant.

