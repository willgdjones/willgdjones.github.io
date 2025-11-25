---
layout: post
title: "Building the Sano Agent"
date: 2025-11-20
description: "A description of building the Santa Agent."

---

This year at Sano, I transitioned from being a majority-time ‘manager CTO’ here to being a majority-time ‘IC CTO’. All of the AI tooling had given me so much motivation and drive that it felt like a natural transition to spend more time as an individual contributor and get back into building.

A big goal for this year was to help accelerate the development of clinical research studies on the Sano platform for both delivery and commercial teams. It took a lot of effort to translate the study specification details that lived in PDF documents into the actual representation using the admin builder tools we had spent so many years crafting.

We were heavily inspired by products like Lovable and Repl.it, which allowed people to create websites and online products using natural language alone, so we set out to build an equivalent at Sano called the Sano Agent.


<figure>
  <img src="/assets/images/SanoAgentSystemDesign.png" alt="Sano Agent System Design">
  <figcaption>Sano Agent System Design</figcaption>
</figure>

1. The client sends the user prompt alongside the user cookie and JavaScript Web Token (JWT), which are used later for authenticating web requests alongside the previous message history.
2. The agent receives the prompt and makes a sequence of *Tool Calls* to fulfil the prompt with the necessary inputs.
3. Each tool call makes web requests to the backend API, which are authenticated with the cookie and the JWT. The exact API calls that are made depend on which tool is called. 
4. The agent server receives status codes back from the back-end API to confirm that entities have been modified correctly. 
5. The agent server streams updates to the client after every agent iteration. Each time a tool call completes, a message is streamed back to the client.

### Backend 

The Agent Server is a standalone service implemented with FastAPI within our mono-repository, similar to how we designed the Kit Operations server.

A key component of the agent server prompt is a reference to all the BlockType classes that we currently support. This enables the Study Agent to accurately select the correct Block Type and Block Data based on a user prompt, but it also introduces a dependency on the core server codebase.

In the future, this context could be automatically generated via an OpenAPI spec or by even hosting our own MCP server directly from our OpenAPI specification. Given the uncertainties in this approach, we decided not to pursue this avenue straight away and instead launch, gather feedback, and generate momentum in this product direction before investing in this longer-term technical approach.


The backend which exposes REST endpoints, such as `/agent/execute-prompt/stream`, which calls an Agent implemented with [PydanticAI](https://ai.pydantic.dev/), and streams back the response after each Tool Call completes until termination.

The Agent has a limited and highly specified set of tools that it is able to call in order to carry out at task:

- Create Study
- Create Flow For Study
- Add Section To Flow
- Delete Flow Section
- Update Order in Flow Section
- Add Block To Flow Section
- Delete Block
- Add JumpTo For Block
- Add Stage To Study
- Delete Stage
- Create Stage Rule For Study
- Update Stage Rule
- Delete Stage Rule

These tools are implemented within `study_agent.py` and are added to the Agent. Each tool is referenced in the system prompt along with instructions and important information.

### Frontend

I implemented a very lightweight frontend component that is rendered within `admin-default.vue`. This means that the chat will, by default, appear on the right-hand side of every page in our Admin Product when the feature flag is enabled.

We used the [Vue EventBus](https://vueuse.org/core/useEventBus/) to dynamically reload data on specific pages in response to messages received from the Agent Server in the chat.

The Study Agent Chat window contains buttons to clear all messages, minimise or maximise the chat, or close it altogether. The Study Agent Chat reappears when the page is reloaded. 

The component collects the context of the Study that the user is currently looking at and collects together all the Flows, Blocks, Stages, Stage Rules, Triggers, that particular study. It adds this context to the prompt that is sent to the agent server. This allows the user to reference study components (e.g., Blocks and Stages) with loose descriptions, and the agent server can determine which components the user is referring to.

### Eval strategy

There are a number of `pytest` cases to validate the behavior of the Study Agent In a variety of different circumstances:

- `test_study_agent_tools.py`
    - Contains test cases to validate the behaviour of individual tool calls of the Study Agent, essentially serving as unit tests.
- `test_study_agent_tasks.py`
    - Contains test cases for complicated multi-step tasks involving multiple tool calls, essentially serving as integration tests.

```
def test_create_study(self, agent_auth_headers):
    """GIVEN a study agent and a prompt for creating a study"""
    prompt = """
    Create me a example study called 'ALS Study' and key 'als-study'.
    Do not create anything else.
    """

    """WHEN running the agent with the full name block prompt"""
    result = run_agent(prompt, agent_auth_headers)
    study_id = result["study_id"]

    """AND a study should be created in the database"""
    study = get_study_details(study_id, agent_auth_headers)
    assert study["title"] == "ALS Study"
    assert study["key"] == "als-study"
    assert study["primary_locale_id"] == "en-gb"
```

These tests provided robustness against the broad variety of prompts that the user agent may receive. They also help ensure that changes to the system prompts do not inadvertently introduce issues with existing functionality. These tests make actual API calls to OpenAI. The intention is not to add these to our CI, but to maintain them as a test suite that runs when required.


## Three iterations of the Sano Agent

### Sano Agent V1

Sano Agent V1 focused on implementing the core pieces of functionality outlined in the vision and to generate buy-in across the company. It served as a successful proof of concept to help people see the vision about what could be achieved if we invested more in this technology approach.
<figure>
  <img src="/assets/images/SanoAgentV1.gif" alt="Sano Agent V1 - ">
  <figcaption>Sano Agent V1</figcaption>
</figure>

### Sano Agent V2

Sano Agent V2 added PDF upload support and required me to break out the previously monolithic agent into a multi-agent system. My initial approach was to implement a retrieval-augmented generation (RAG) system to split large PDFs into chunks, generate embeddings from them, and augment generations with relevant chunks. However, I found that this introduced significant issues with the order of questions within pre-screening flows, which is extremely important to users. I resorted to using long-context models such as Gemini 2.5 and later Claude Sonnet 4.5, along with ChatGPT 4.1, whose 1-million-context-length was sufficient to ingest full-length PDFs, summarise them, extract the relevant content, and pass it to the main model to create the necessary study components.

I encountered new issues when attempting to one-shot the study's landing page due to its complex JSON representation. We represented landing pages as a list of sections, each validated as a Pydantic model. After several failed attempts, I found a practical approach that implemented a dedicated landing page agent with two tools, one to add a section and the other to delete a section, which built up a landing page by iteratively adding sections to either an empty JSON representation or an existing JSON representation. This allowed users not only to create a landing page from scratch but also to edit an existing one.


<figure style="max-width: 50%; margin-left: auto; margin-right: auto;">
  <img src="/assets/images/SanoAgentV2.gif" alt="Sano Agent V2">
  <figcaption>Sano Agent V2 - splits Agent behaviour into a Plan mode and an Execute mode</figcaption>
</figure>

<figure style="max-width: 70%; margin-left: auto; margin-right: auto;">
  <img src="/assets/images/AgentDiagrams.jpg" alt="Agent Diagrams">
  <figcaption>Architecture of the Multi-Agent System</figcaption>
</figure>

### Sano Agent V3

In Sano Agent V3, I implemented the client-server interaction using an emerging standard called AG-UI. This is a protocol with well-defined methods for clients to enter and interact with agents via web services, which is exactly what the Sano agent was. Instead of parsing the raw streaming events on the client, it allows the client to subscribe to specific events emitted by the server that indicate intermediate steps. This also allowed me to stream intermediate events from sub-agents, which was previously not possible, resulting in a very clearly informed user experience.

In addition, I finalised a deep research sub-agent that enabled users to informatino from the internet about large scala therapeutic programs our clients were running and build those studies on our platform immediately.


<figure style="max-width: 50%; margin-left: auto; margin-right: auto;">
  <img src="/assets/images/SanoAgentV3.gif" alt="Sano Agent V3 ">
  <figcaption>Sano Agent V3 - breaks down the task into intermediate steps that dynamically update</figcaption>
</figure>

