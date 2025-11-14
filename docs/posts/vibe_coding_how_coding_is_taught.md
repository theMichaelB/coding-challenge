date: 6-nov-2025
title: Vibe coding will become the way coding is taught

---

I spent much of my career troubleshooting enterprise application and architectural issues. Often, that meant firing up a network analyser to see what was really happening under the hood. What helped most in those moments was an early decision I made to read the Internet Engineering Task Force documentation for the protocols that run the internet.

A fundamental concept in networking is the OSI model - the framework that defines how every packet of information moves through every network, from a mobile phone signal to transoceanic fibre. It begins at the physical layer, describing how a piece of wire can transmit information in a way that allows a network packet to form. Each layer builds on the one below it, abstracting complexity while adding new capability. It’s an elegant system that works at every scale.

Whenever I try to understand a complex technology - or even something outside of technology - I find myself looking for its equivalent of the OSI model. The same principle applies to human systems, to language, to how teams and organisations operate. Each has its own stack of abstractions, layers that depend on one another.

Lately, I’ve been thinking about how software engineering maps to that idea. This is what I came up with.

Seven Layers of Software Engineering

Syntax & Basic Logic - Making the computer execute commands through variables, loops, and conditionals.

Code Organization - Structuring code into functions, modules, and files so it’s functional rather than chaotic.

Abstraction & Interface Design - Defining clear boundaries between components, hiding complexity behind well-designed interfaces.

Design Patterns & Local Architecture - Understanding how components within a system should relate and interact, knowing when to apply patterns and anticipating future changes.

System Architecture - Designing how services, modules, and major components communicate and work together across the entire system.

Organizational & Sociotechnical Architecture - Aligning team structure, communication patterns, and technical decisions, recognising that systems mirror organisational structure.

Product & Business Architecture - Understanding why you’re building what you’re building, making technical decisions that align with business value and user needs.

When you begin learning software engineering, this is the ladder you climb. You start with “hello world”, then loop it five times, then pass a parameter to greet someone by name. Over time, you move upward through the layers - from syntax to structure, from systems to strategy.

That progression has been constant since the 1960s: you learn the code, then you learn to organise it, then you learn to make it understandable, then you learn to design systems that work together.

What’s interesting is how AI has begun to climb those same layers.

When GitHub Copilot first appeared, seeing VS Code complete a line of code felt magical. That was AI stepping onto the first layer – it understood syntax and flow well enough to predict what came next. Soon after, it could generate entire functions from a short comment or a well-named definition. It often made a mess of it, but it was standing, a little unsteadily, on the edge of layer 2.

Then GPT-3.5 arrived, and suddenly it could handle abstraction. It could create interfaces, and with some success, even propose interface specifications. Layer 3 met the large language model.

Fast forward to today: layers 1 through 3 are essentially solved. Layer 4 – design patterns and local architecture – is within reach, though only with human supervision and iterative feedback across multiple sessions. It’s the layer where AI starts reasoning about relationships, not just code. And while it doesn’t always get it right, it’s clearly climbing.

This next part will make existing software engineers, who have spent years climbing those layers, reach for their pitchforks.

If AI is already fluent in layers 1 through 3, why should anyone still learn them? Why not just lean on what the machine already knows?

It’s a fair question.

You might ask: how can you debug something you can’t read?

The same way you debug a database you didn’t write, a compiler you don’t understand, or a cloud service you can’t see inside. You debug behavior, not implementation. The test tells you what broke. You refine the specification. AI regenerates. The tests verify the fix.

What about security? Surely you need to audit the code.

If reading code were the surest way to find vulnerabilities, security audits wouldn’t be so difficult or expensive. In reality, we already trust vast amounts of unaudited code, every dependency, every container, every cloud service API. We rely on testing, monitoring, and behavioral verification because reading doesn’t scale. Security is proven by what code does, not by what it says.

And yes, reading code teaches you how to write better code. But at a certain point, the higher-value learning isn’t in syntax, it’s in structure. Reading architecture teaches design. Reading user stories teaches empathy. Reading test failures teaches discipline. The skill that matters most is not reading code but reasoning about systems.

You might say this only works for simple applications. Yet consider a data scientist using Rust for performance without knowing the language, or a startup building polyglot microservices where no one knows every stack. Complexity doesn’t demand total understanding - it demands clear specifications and rigorous verification.

What happens when AI gets it wrong? The same thing that happens when a developer does: tests fail, monitoring alerts, users complain. You don’t fix it by reading code - you fix it by clarifying what correct behavior looks like, then regenerating. The code is disposable; the specification is the source of truth.

So no, this doesn’t create hollow developers. It creates ones who think in systems, verification, and design rather than syntax. Most engineers already work this way - they understand distributed systems without knowing TCP/IP internals, or databases without reading B-tree implementations.

Programming languages still matter, of course - for performance, ecosystem, tooling, and team velocity. They just don’t matter to you as a personal prerequisite if AI can translate your specifications into any language. The language becomes a design choice, not an initiation rite.

This shift doesn’t make development easier. It just moves the difficulty higher up the ladder. You still need to learn how to define what should exist, how to test whether it works, and how to integrate it into something valuable. That’s not less demanding - it’s just finally focused on the real problem: understanding what to build and ensuring it works.

This isn’t to say code-level understanding no longer matters. While AI still struggles with layer 4 and above, production systems depend on experienced developers to review generated code, catch subtle errors, and ensure architectural intent is preserved. That need will diminish as AI climbs higher in the stack - but for now, human verification is still part of the scaffolding.

But here’s what I think is really happening, the bottom three layers aren’t just being automated - they are being replaced entirely. The skills required to work effectively at those levels have fundamentally changed. Where we once climbed from syntax to structure to abstraction, we now need different capabilities altogether. The foundation of the stack looks different now.

Instead of the Syntax, Organisation, Abstraction layers, I think those layers have been replaced by a requirement to better communicate with AI.

The new layers move from creating code, to expressing intent.

User Story Expression – learning to express atomic units of intent clearly enough for a model to act on them.

Intent Organisation – structuring multiple user stories into coherent, interdependent objectives.

Orchestration – managing the interaction itself: sequencing actions, adapting to results, handling failure and rollback, and steering the model toward completion through guided iteration.

Collaborative Design & Local Architecture – working with the model to translate intent into coherent structures, applying design principles, patterns, and abstractions to balance clarity, performance, and maintainability.

It’s hard to see a future where this doesn’t become the way people learn to build software. Whether the model is entirely right or not, I don’t know — that’s what exploration is for. The only way to find out is to try it and see how it works in practice.

That’s the purpose of this Substack: to begin experimenting with this new model of software development. I want to teach people how to build applications without beginning from code itself — to learn by collaborating with AI, developing intuition, structure, and intent before syntax ever enters the picture.

So if the idea of learning to code without learning code is appealing, then subscribe, follow, send a message. Hopefully it is a journey that will teach us all something interesting.

Since we started with the IETF, if you send a message via RFC 1149 (avian carrier), I’ll be considerably impressed.


