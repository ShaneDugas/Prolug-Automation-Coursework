Unit 13 Discussion Post 1: Your management has been discussing ways to reduce errors in your current “wild wild west” environment.  Read about configuration management here: https://en.wikipedia.org/wiki/Configuration_management
  a.    What overlap of terms and concepts do you see from this week’s meeting?
  b.    What are some of the standards and guidelines organizations involved with configuration management?
      i.    Do you recognize them from other IT activities?
```
For this chapter, instead of repeating previous work from a security course, I decided to revisit those labs and think about them from a different perspective/experience.
```
### Digging Deeper challenge
1. Complete this lab: <https://killercoda.com/het-tanis/course/Ansible-Labs/19-Ansible-csv-report>
   - Can you think about how you’d use this to verify that a system was stamped
     according to your build process?
     - You may have to tie it in with something like this lab and add some variables
       to your custom facts files, maybe the date of deployment:
       <https://killercoda.com/het-tanis/course/Ansible-Labs/12-Ansible-System-Facts-Grouping>
```
Generalistically speaking, from the standpoint of just about any environment where idempotency would be a goal or target you're concerned with,I would say that a couple of things just totally make sense as no-brainers:
1. Version control using whatever toolset you have available. Git, GitHub, Git labs, Azure Devops, Bitbucket etc.
2. Documentation. Having a method to the madness that can be reconciled as some type of standard-of-truth is worth its weight in gold. I think here is where you could begin some type of stamping or labeling or naming that indicates:
- time
- date
- modifications
- who did it
- why'd they do it
Just like properly placed comments are critical for "figuring out what's going on", having the ability to understand what you were doing when you come back to it six months from now and having a standardized system that everyone can use and understand, is equally important.  Standardized and MAINTAINED documentation is one of many keys to sucess.
```