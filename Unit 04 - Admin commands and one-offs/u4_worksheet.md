# ProLUG Automation

## Unit 4 Worksheet

## Instructions

Fill out this sheet as you progress through the lab and discussions. Hold your worksheets until
the end to turn them in as a final submission packet.


## Discussion Questions:

### Unit 4 Discussion Post 1
Your company is on a normal 3 year refresh cycle for hardware.
This means that they purchase ~1/3 of hardware in each year budget. You have 6 months
until the next purchase but have been having storage capacity issues in some of your
servers. Your team sits down and works out a plan to put in place some “Stop gap”
measures to keep the system running until the next deployment.

1. Find an article that discusses what “stop gap” measures are.

2. What is your understanding of the term “stop gap”.
```
I've always thought of a stop-gap as something you did temporarily. "For the time being" maybe.  Like stopping the leak with your finger, so to speak.
```

3. What are some things you would be doing to help a system that has no way to add
   capacity before a certain time to continue operations between here and there?
```
Things we have to do today...
I would start with looking for data that could be moved off-system or deleted. I'd start by looking for old backups, log files that are outside of retention scope. (maybe old package repos or caches) System level stuff.
    There is also the user end.  There's a possibility that the application / users of the system could potentially bear some of the burden of helping with a stop-gap solution until the new storage space is available.
Things we work on next...
Do we have de-duplication solutions in place? What about monitoring? Could we implement something to monitor and give more finite or specific notifications about the overall state of storage on the system?
```
    

    - What is meant by the term “draconian measures” in this context?
    
```
    Here I immediately went back to the PSC unit 1.....found it.....Discussion post 2.
    
Vul ID**: V-253677   Rule ID**: SV-253677r1043188_rule   STIG ID**: MADB-10-001700   Severity: CAT II   Classification: Unclass
Rule Title: MariaDB must by default shut down upon audit failure, to include the unavailability of space for more audit log records; or must be configurable to shut down upon audit failure.
This would be a Managerial and/or Operational - Detective control since it involves "incident reporting processes" or " Log reviews, monitoring"
        I'm thinking this  would satisfy the draconian response in this situation. (Depending on the system or service, that is.) 
```




### Unit 4 Discussion Post 2

You and your security team have an accurate inventory after last
week’s misunderstanding. You have 110 servers currently in your inventory. What are some
methods you can use to verify those systems are operational?

1. How might you “touch” those servers every day?
```
This could be an automated scan or pingsweep etc.
```
2. How might you plan to keep that inventory updated automatically?
```
We could reach out to it with automation and update some dashboard or reporting application.
```
3. How might you monitor those servers? (What tools can you find that would do this?)
```
We can use telemetry to report out (Node exporter/Prometheus). If the system has virtualized system integration we can integrate the hypervisor's API if available. They usually do this anyway.
```
4. How might you present a report for these servers (to your team or others?)
```
Dashboarding with Grafana/Kibana might work for some audiences.  Technical team members might be comfortable with a simple script driven automation that writes out "I'm ok" if all is well. Depending on the need, there is a reporting solution for just about anyone. We just have to build it out.
```

## Definitions/Terminology

- One-off
- Ad-hoc
- Admin Commands
- Stop gap fix
    - How does this relate to a full implementation?
    - How does this relate to a systemic system problem?
    - How does this relate to a systemic capacity problem?
- System load (and utilization ((always as a percentage)) )
    - Averages
    - High water mark
    - Low water mark
    - Spiking
    - Capacity


## Notes During Lecture/Class:
Links:
•
Terms:
Useful tools:


## Lab and Assignment
Unit4 Lab from Lab book
<https://killercoda.com/het-tanis/course/AutomationLabs/Unit4_Admin_Commands>


## Digging Deeper

1. Read this article about Ansible ad-hoc commands
   <https://docs.ansible.com/ansible/latest/command_guide/intro_adhoc.html>

    1. What did you learn about this that you didn’t know?

    2. How are you going to use this in your current or future automations?

## Reflection Questions

1. What questions do you still have about this week?

2. How are you going to use what you’ve learned in your current role?

