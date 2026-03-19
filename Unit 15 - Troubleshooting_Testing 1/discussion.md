Discussion 1
Your team has been plagued by a string of incidents after going to production. In your after action reviews, and incident post mortems it has been found that documentation and mean time to detect (MTTD) was acceptable. What was causing the long wait times was administrators making the decision to implement the fix. 

You decide to research some standard methodologies around decision making to help your administrators better act on active incidents.

What is PDCA?```
Plan Do Check Act.  Variations: plan-do-study-act (PDSA) cycle, Deming cycle, Shewhart cycle```
What is OODA?
```
OODA stands for Observe, Orient, Decide, Act. It as a repeating decision cycle developed by John Boyd, with orientation especially important because it shapes how people interpret what they observe and what action they choose.

In the above scenario, the admins have a hesitation problem. This is likely the most useful model for live incidents because it helps admins quickly assess conditions, interpret what they mean, choose an action, and then reassess as the situation changes.

I picked OODA as the best solution path since it is built for fast, imperfect, iterative decisions under pressure, which is exactly what seems to be needed. Maybe the admins feel like they don't have the permission they need to implement the fix but this methodology incorporates a decision along with a reassessment. (The permission becomes baked into the process)
```
What is FMEA?
```
FMEA stands for Failure Mode and Effects Analysis
```

What is a Ishikawa diagram?
```
An Ishikawa diagram, also called a fishbone or cause-and-effect diagram
```

Can you find any good blogs or discussion posts on the topic of troubleshooting?
```
https://sre.google/sre-book/effective-troubleshooting/
Beware of rabbit-hole below.  Good reads.
https://www.honeycomb.io/blog/why-intuitive-troubleshooting-stopped-working
https://en.wikipedia.org/wiki/Cynefin_framework
```

---
Discussion 2
Automation - Unit 15/16 Discussion 2

An  error has been introduced in your automation code base. You have done all the due diligence in your teams and properly tested in lower environment, but the issue still keeps popping up 10% of the time in prod. 

What are your options for rolling back go a previous version of the code if your team is using Git? What if your team is not properly committing code? How might you roll that back, or prevent these types of errors? 

```
There are many nuanced aspects of CI/CD that may or may not be invovled in an automation framework but the gist of what this question is asking is around Git implementations and not just code/team/workflows.

In a team that uses Git correctly, the best rollback options are usually to revert the bad commit, redeploy the last known-good tagged release, or roll back the deployment artifact such as a container image or package. git revert is often the safest method in shared branches because it preserves history and creates an auditable record of the rollback. If the team tags releases and stores immutable artifacts, they can quickly redeploy the prior stable version instead of trying to debug production issues under pressure. 

Git reset it's also an option under certain conditions. One situation is if it is a private or local branch or if the commit hasn't been widely shared. Its consequences need to be understood from a team's perspective though, since it rewrites history, which may not be desirable for auditing purposes.

If the team is not properly committing code, rollback becomes much harder because Git is no longer a trustworthy system of record. In that case, the team may have to restore from build artifacts, snapshots, backups, previous deployments, or even files copied from production or staging systems. This is slower and riskier because it introduces uncertainty about what version was actually running. If source control discipline is poor, one of the first corrective actions should be to freeze releases, identify the last known-good production state, and rebuild a clean baseline in version control.

To prevent these issues, you should enforce proper Git workflows, including pull requests, branch protection, release tagging, CI/CD validation, and immutable artifacts. You could also use safer deployment strategies such as blue/green deployments, canary releases, health checks, and feature flags so that failures can be detected early and rolled back automatically. The key lesson is that successful rollback depends not just on Git itself, but on disciplined release engineering.  Managed and maintained procedures and systems are key.
```