

There’s a companion article for this piece, not for you to study directly, but for your AI companion to read. It gives the AI the background and context it needs to help you explore the ideas here more deeply. If you’re curious, you can absolutely read it, but it’s mainly there so your AI understands the shape, intent, and learning approach behind this series.

To get started, copy the following message and share it with your AI assistant:

```plaintext
http://www.pkms.dev.s3-website-us-east-1.amazonaws.com/networking/basics/ - I am reading an article described in this link, please read the content so you can assist me with understanding the topics more thoroughly. 
```

### Section 1: The Connected World

A fact that surprises most non-technical people is that the wire bringing the internet into your home is, through a broad collection of devices, and corporate entities, physically connected to every computer on the internet. In much the same way your house is connected to every other house in the country by roads, your home connection is part of a vast global network. Every website you visit, every WhatsApp message you send, every post you like, each of those interactions travels along that chain of copper and glass, from your wall socket all the way to a server on the other side of the planet.

### Section 2: Every House Needs an Address

Just like your house has an address, so does your computer, and just like you can navigate to any other house by using its address, computers have something similar, but a computers address - An IP (Internet Protocol) address - provides an address for every computer around the world. 

To put the scale of the internet into perspective, here’s how IP addresses work. An IP address is made of four sets of numbers, from 0 to 255, seperated by a dot. That looks something like this 1.0.255.10 this roughly translates to around 4.3 billion addresses. For a few years now, there has been a lot of effort put into using these addresses more efficiently, because there aren’t enough left. There is a new version of how IP addresses work, called IPv6 - we’re currently on IPV4 (nobody knows what happened to IPV5) - But nobody likes IPv6 very much, so mostly people try to ignore it. 

### Section 3: The Internet’s Phone Book

But if every time you wanted to go to facebook, you had to type 163.70.151.35, or Amazon, 205.251.242.103, or gmail 142.251.30.19. You can see how that would very quickly get tedious. So the internet has a phone book, called DNS (Domain name service) and whenever you want to check your email your device checks with DNS to translate the name into an address, and then goes and has a conversation with that address. 

When you start a conversation with gmail’s address, the server needs to know whether you want to see the webpage or send an email. It does this with a small addition to the address. For email, your device would send a message to 142.251.30.19:25, for a webpage it would go to 142.251.30.19:443. The part after the : is called the port number and is the way that devices and computers know that they’re having the same conversation, in the same language. 

### Section 4: Sharing an Address

Imagine for a second that street addresses were a limited resource, and as a result were something you needed to pay for. So you and a group of friends say “hey, we all need an address, but rather than all paying for one individually, we could just get one and share it”. This is one of the strategies used to preserve IPv4 addresses. For the devices and computers in your home, each one needs an IP address, in order to talk to your internet router (and each other). So your router has a single Public IP address on the internet, and creates Private IP addresses for everything attached to it. This means that your TV can connect to the internet but anyone on the internet can’t connect to it. This is called NAT (Network Address Translation) it not only preserves address space, but also keeps your devices protected because they can’t be directly accessed from the internet. 

### Section 5: The Shape of Things

And that is the start of how things connect to each other over the internet. It is very simplified (and some parts are outright wrong - but we’ll correct those later). It is an incredibly complex topic, and this is about showing you the shape of things, rather than a tedious, long winded definition. 

If there are any parts you’re unsure about, or don’t understand, or if you just want to find out where I lied (so you can flame me in comments), use the prompt at the top of the page and go and discuss the article with your favourite AI. 


