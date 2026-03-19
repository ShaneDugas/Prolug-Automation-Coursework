Unit 7 Discussion Post 1: You are the team lead of a small Linux team maintaining 700 servers. Your management is always pushing for getting more from the systems and has been asking you to explore container environments, especially in the cloud. You read some blog posts about services and decide to write out your notes: https://aws.amazon.com/blogs/containers/amazon-ecs-vs-amazon-eks-making-sense-of-aws-container-services/
What are the major differences between container environments and Kubernetes orchestrated environments?
a.    Why might you just want a containerized environment?
	My understanding, at a very high/simple level, the ECS is more like a DIY solution and the EKS is a more granular, robust, tunable solution that allows for the power of Kubernetes throughout.
b.    Why might you want an orchestrated environment?
	Maybe you need a "turnkey solution" that doesn't require a lot of micromanaging or config complexity? Maybe you need to build out a network of containerized machines by config, repeatable, so you can test the real "Thing" that you are working on somewhere else?
c.    Can you compare and contrast them?
	At this point, in my kube knowledge journey, I do not think I can answer this off the cuff.  I feel like there is a very high layer of complexity involved in deploying these systems as "entire solutions"

---

(But really Unit 7) Unit 7 Discussion Post 2: Your team is having problems with a deployment. This is the code snippet they are using.
What is the provider they are using?
How many docker instance are they trying to run, and what are their names?
a.    What ports are they going to be running on?
Your team is having problems executing this and have brought it to you. What might you check, or do with terraform to try to resolve the issue?
a.    If it’s telling you there are no providers?
b.    If it’s saying there’s a syntax problem (how can you find it)?
c.    If there are no resources created?
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx8080" {
  image = docker_image.nginx.latest
  name  = "nginx8080"
  ports {
    internal = 80
    external = 8080
  }
}

resource "docker_container" "nginx8081" {
  image = docker_image.nginx.latest
  name  = "nginx8081"
  ports {
    internal = 80
    external = 8081
  }
}

resource "docker_container" "nginx8082" {
  image = docker_image.nginx.latest
  name  = "nginx8082"
  ports {
    internal = 80
    external = 8082
  }
}

---
The following is my mistaken coursework.  I answered the Unit 8 Security course discussion.  Posted them anyway
---
Unit 8 Discussion Post 2: Review the SRE guide to treating configurations as code. Read as much as you like, but focus down on the “Practical Advice” section: https://google.github.io/building-secure-and-reliable-systems/raw/ch14.html#treat_configuration_as_code
a.    What are the best practices that you can use in your configuration management adherence?
```
Store config in source repo (alongside application code if possible)
Validate config through dry-runs or semantic checks.
Don't mod prod systems when possible. Rely on controlled tests or rolloutss. Staged deployments.
```
b.    What are the security threats and how can you mitigate them?
```	
Threats...
Direct edits on prod systems can open the door for vulnerabilities by bypassing review and audit. This could lead to possible exploitation
Configuration drift can be a problem.
Modification of config - Misconfigured parameters. Ad-hoc commands?
--
Mitigation...
I would think first principle security principles would go a long way in this regard.  Access control (least priveledge - proper cryto signing etc), code review with an official approval process, automate deployment pipeline with integrity checks.  (I've studied this last part as a security topic (CISSP etc) but I'm not familiar with any applications or procedures for acomplishing it.)
```
c.    Why might it be good to know this as you design a CMDB or CI/CD pipeline?
```
CMDB can be painful on it's own right? (No experience as admin here) Surely keeping your configs in disarray and slopiness can only add to perpetuate the agony some people talk about with these platforms.  To me, organization with config code (good habits between engineers) allows for better understanding from everyone involved. This could easily point back to 5s principles, as everyone rolls their eyes, but increasing understanding and communicating well decreases human error which ultimately increases security posture.
```

