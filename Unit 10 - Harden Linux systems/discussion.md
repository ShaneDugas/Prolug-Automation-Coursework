Unit 10 Discussion Post 1: Your team uses Ansible and needs to secure one of the images you have been working to build in Rocky 9. You have decided to use https://github.com/ansible-lockdown ansible Lockdown for STIG remediation. 
Where is this tool designed to be run?

Ansible Lockdown is a tool created by the MindPoint group. It has two major functions: to audit and to remediate. It does this by comparing the system against a known configuration, usually built from industry standards, CIS, or STIG.
It uses Goss for auditing (which can be kicked off by Ansible.) and it uses Ansible for remediation.  In most situations, this would not be run in production environments. This is due to the volatility of many of the controls that it is designed to configure or reconfigure. (there may be scenarios where you could complete or use the auditing part of the tool in production?) 

It appears to be a highly configured and customized set of frameworks pre-built for testing on a large set of operating systems and environments. 

a.    Why is this going to cause you a problem?
How will you go about remediating problems in your environment, if you have to run this in a chrooted environment?

In most cases, in order to audit a system, you would have to have root file system permissions. This will be problematic with a chrooted environment since its whole purpose is to isolate from the kernel/file system.  I'm guessing this would be an instance where you would want to use something like Ansible Molecule to have an environment set up with your image and use lockdown against that environment. This seems more like an environment building/test-tool in this scenario though.


---


Unit 10 Discussion Post 2: Read these blog posts about CIS and STIG compliance:  https://www.mindpointgroup.com/blog/stig-vs-cis-part-1-the-anatomy-of-baselines-and-compliance?lockdownenterprise https://www.mindpointgroup.com/blog/stig-vs-cis-part-2-selecting-the-best-baseline-for-your-business?lockdownenterprise
Why might you want to choose one over the other?
Which version of baseline tool aligns with your current industry, or the industry you’re wanting to work in?

The link outlines the idea very concisely. These are just baselines, teams would have to ultimately pick between STIG or CIS, but they would never be complete solutions by themselves. If you were in the system architecture stage, I would say you would decide which baseline would get you closer to your ultimate goal and requirements, and then proceed from there. For instance, if you were in the data safeguarding business/ HIPAA/ GDPR realms, you would need a whole different approach to securing that data than if you were in a systems access type of scenario where you were more worried about zero trust and identity access management.  Both sets of standards are very similarly aligned, but they have their niche specifics that they satisfy, which ultimately determines which solution gets selected as the baseline.