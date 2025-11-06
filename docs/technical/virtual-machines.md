# Virtual Machines and Containers

When you rent server space from Amazon Web Services, you’re not getting your own physical computer sitting in a warehouse somewhere. You’re getting a slice of a much larger machine—and understanding how that slicing works helps explain two fundamental technologies: virtual machines and containers.

## The Hardware Reality

The largest server you can rent from Amazon will cost you $90,000 a month, it has 896 processors and 1,200 GB of memory. Your laptop might have 4 processors and 16 GB of memory. The gap is enormous, but the real innovation isn’t just the size of these machines. It’s how they can be divided up.

## Virtual Machines: Multiple Computers on One Machine

A technology called virtualization made AWS possible. It allows you to run multiple separate computers on a single piece of hardware by giving each one a “virtual” slice of the CPU and memory.

Before virtualization, if a business needed a file server, an email server, and a web server, they had to buy three physical machines. But here’s the thing: most servers spend most of their time doing nothing. A file server’s CPU barely works. An email server sits idle between messages.

Virtualization let companies stack multiple computers onto one piece of hardware. Each was still a completely separate machine, one serving files, another handling email, another running the website. But they all shared the same physical processors and memory underneath.

The other benefit: it’s all software. No one needs to plug in network cables or power cords. You can manage everything automatically with scripts and timers. Need your payroll system to run for two hours once a month? Set it up once, and it handles itself.

Amazon took this idea and built it at massive scale. That 896-processor machine? It could become 448 separate computers with 2 processors each, all being created, started, stopped, and destroyed automatically based on what customers needed.

## The Problem Virtual Machines Solved (And Created)

Virtual machines also solved a classic software conflict problem. Sometimes an email server needs version 1 of a database program, but a file server needs version 2. Installing both on the same machine causes chaos.

With virtual machines, you install each application into its own machine. They never know they’re running on the same hardware, so the software conflicts disappear.

But this created a new inefficiency: every virtual machine needs its own complete operating system. Operating systems consume significant resources, memory, storage, processing power. The more operating systems you’re running, the less you have available for actual useful work.

## Containers: The More Efficient Slice

This is where containers emerged.

Imagine you could take an application, compress it into a single file with everything it needs, and just run that file. Because everything is self-contained, it can’t interfere with anything else. One container can have version 1 of a database, another can have version 2, but because they’re isolated in their own packages, they can’t see each other.

The crucial difference: containers share the same operating system. Instead of running ten operating systems to support ten applications, you run one operating system and ten containers. You get the isolation benefits of virtual machines with far less overhead.

Containers also make cleanup simple. When you’re done with an application, you delete the container, and nothing is left behind. No configuration files scattered across the system, no forgotten dependencies—just remove the container, and it’s gone.

## Spot Instances: The Exception Worth Knowing

Knowing that AWS uses virtual machines? Honestly, that doesn’t change much for you. It’s happening behind the scenes, and you’ll probably never think about it.

Except for one type: spot instances.

AWS sells virtual machines at set prices. To make cloud computing attractive, they need instant availability, which means they always maintain more capacity than they have customers. At AWS’s scale, with hundreds of thousands of machines, that excess capacity gets expensive.

Their solution: offer you a steep discount - up to 80% off - if you’re willing to accept that your machine might be shut down at any point. You get a two-minute warning before it’s taken away.

What’s the point of that? As long as you plan for it, it’s a powerful way to save money.

I use spot instances as development machines. The standard cost for the size I use is $80 a month. If I’m careful about turning it off when not in use, that drops to around $30. But with spot instances, that easily comes down to $10-15 a month. For the size you’ll likely use, that will easily be below $5. 

By spending a few hours working with AI to automate backup, restore, startup, and shutdown, I get a clean machine whenever I need it that automatically shuts down when I’m not using it. While theoretically I should get two-minute warnings before shutdown, I can’t remember ever receiving one. In practice, it works exactly like the full-price version, but at a fraction of the cost.

## Why This Matters for You

Containers will become useful tools. They let you test software without installing it permanently on your machine. Want to see what your website looks like in a specific version of a browser? Run it in a container. Need to test if your code works with a different database? Spin up a container with that database, test it, then delete the container when you’re done.

The pattern you’ll see repeatedly: containers give you clean, temporary environments for trying things out. They’re especially helpful when you’re working with AI to build something. You can experiment freely, knowing that nothing you do will mess up your main system.

---

