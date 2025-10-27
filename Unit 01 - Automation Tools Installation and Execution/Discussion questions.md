
1. If you’ve done the previous courses, how would you define administration? If you haven’t find a blog (link for us) and explain how they define administration of Linux systems.
2. If you’ve done the previous course, how would you define security? If you haven’t find a blog (link for us) and explain how they define security of Linux systems.
3. When you think about automation, how does it tie into things you do on a daily basis, inside or outside of computer systems?

```
This is a current (2025) article that incorporates aspects of all three questions at once. While it is a server patching management solution, the page links to several sources that offer insight into several key considerations about the "HOW" and "WHY".  With the advent of modern, easy to use, AI tools, the industry must pivot in order to stay ahead in a landscape of growing threats.  The ability to automate the admin and security compliance of linux servers is an ever-growing necessity moving forward.

The article talks about end-to-end automated patching and software distribution, server lifecycle management, and security compliance and security. If you consider trying to do even some of these as an individual or even as a team, you can easily see how this could be overwhelming or even impossible for some.  Automation offers the means of managing larger systems and tasks.  
https://jetpatch.com/blog/patch-management/linux-patching-benefits/

```

```
Automation - Something that reduces human intervention/interaction
```


1. What is your definition of a trigger?
```
A logical state or analog threshold that determines, or can be used to determine, an action level or response to change.
```
2. What are the types of triggers you read or can define?
```
A trigger in a linux system could be based on a time or an analog metric value, a digital condition or state, or even a signal sent from outside the system, like an event based trigger.  An automation can also be manually triggered.  
```
3. Where would you place these triggers to positively affect your ability to build or administer Linux systems?
```
The trigger needs to be definable and readable by the system that is acting in response to it's condition.
```



I immediately go to testing and troubleshooting when I read this.
I'm currently troubleshooting / dealing with a reporting automation.
    Every morning at a scheduled time a service opens excel, pulls data from an api, does a calc, spits out a report in PDF format AND prints to an HP printer. (Domain print server with drivers there) Excel print function is borked. Which part of the automation is broken?
        Time is finitely configurable.  I can change the system time.  I can change the programming time.  In this case, time is known and predictable.
        The event portion however, is not.  There are multi facets that cascade due to a system event.  If something else downstream breaks, we have to have a way to initiate a test point for troubleshooting.  In this case, I have a manual "Click" I can execute to run the automation for testing.
        