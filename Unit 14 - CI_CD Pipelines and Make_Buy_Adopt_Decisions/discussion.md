Unit 14 Discussion Post 1: Your management has invited you to an architecture meeting called “Technology adoption matrix discussion”. You’ve heard the managers talk about using Make v. Buy v. Adopt decisions for technology. So you decide to research it online a bit.
What is likely to be discussed in this meeting?
```
This is probably a mid to high level management meeting.  It will most probably include topics centered around strategic control vs. speed vs. cost, of whatever technological topic the meeting is about.
```

What are the major considerations for make v. buy v. adopt?
```
Consideration,Make (Build),Buy,Adopt (Open Source/Internal)
Competitive Edge,High; you own the IP and unique features.,Low; your competitors can buy the same tool.,Moderate; depends on how you customize it.
Time to Market,Slow; requires full dev lifecycle.,"Fast; ""plug and play"" (usually).",Medium; requires setup and integration.
Total Cost (TCO),High upfront (salaries) + High maintenance.,Predictable licensing fees + Integration costs.,"Low upfront + High ""hidden"" support costs."
Control/Security,Total control over data and updates.,Dependent on vendor roadmap and security.,"High control, but you must patch it yourself."
Skill Set,Need deep expertise to build/maintain.,"Need ""Integrator"" skills and vendor management.",Need experts who understand the codebase.

```
Where are you going to go online to help you prepare for this meeting?
```
A simple search of "Technology adoption matrix" yeilded mildly satisfactory results.  Adding the constraint of "Cloud automation" seemed to return a more relavant set of results.

Other interesting finds were...
Gartner or Forrester: Search for "Technology Lifecycle" or "Magic Quadrants." These sites provide the industry-standard "Buy" options for almost any category.

Wardley Mapping: Research "Simon Wardley’s Value Chain Mapping." It is a brilliant way to visualize which technologies are "Genesis" (Build) vs. "Commodity" (Buy/Adopt).
```

![[Pasted image 20260225012646.png]]





Unit 14 Discussion Post 2: Your team has a wide variety of open source tooling that they use for monitoring. The structure and web of technologies has gotten too large to maintain and documentation for it is not able to help the junior engineers keep things running without tribal knowledge. You want to find a viable set of monitoring tools that are well supported and work together. You have found yourself here: https://landscape.cncf.io/
What are some viable observability tools on that page?
```
For observability, there are many here that provide viable solutions.  I'd go with some of the known players that have been tried and tested for a while.  The elastic or grafana stacks for logs and observability and prometheus for metrics.
```

What considerations would you need to think about bringing them into your test environment?
```
Complexity and ease of learning are things that come to mind first.  If something is overly complex to maintain, how much will you gain trying to get out of the "tribal knowledge" rut you're trying to avoid? Implementing something like a "family" stack may be more benificial if it contains all the tools you need and they talk easily to each other.  This could reduce the 'learning curve' and allow a faster turnaround for the whole project evolution.
```