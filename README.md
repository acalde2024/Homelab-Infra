# About my Homelab

Welcome to my new homelab journey. I started t his journey a year ago when I started using a RaspberryPI2 to run PiHole and eventually grew into a full grown server that runs my network, media and monitoring tools to better upskill my IT work

# Why Upgrade?

Well from my last repo, I mainly used Ubuntu + docker enginer to run all my services. It was fun, learned a lot about how containers work, how docker compose works and how easy is it to scale if something goes down. However I fell into a new rabbit hole called "Type 1 Hypervisor" aka using Proxmox to virtualize everything. I wanted to learn how VMs work vs containers, how is it different and how to work from an enterprise looking environment. There my proxmox server sprung. I also wanted to start messing with OPNSense to start diving deep into networking, firewall, DHCP server, DNS server, etc..

# Hardware

<dl>
    <dt>Dell Percision 3420</dt>
        <dd>- 1TB HDD</dd>
        <dd>- 16GB of RAM</dd>
        <dd>- Proxmox</dd>
        <dd>- Dual 1G NIC Card</dd>
    <dt>Dell Optiplex Micro 3040</dt>
        <dd>- 500GB HDD</dd>
        <dd>- Proxmox Backup Server</dt>
        <dd>- 8GB of RAM</dd>
    <dt>Networking Hardware</dt>
        <dd>- Omada EAP650 AP's</dd>
        <dd>- TP-Link SG108E Gigabit Switch</dd>

# Documentation

Quick breakdwon on my architecure and how 

<dl> Running Services </dl>
    <dt>OPNSense - Firewall/Router</dt>
    <dt>Omada - My AP Controller</dt>
    <dt>Homarr - Server's Homepage</dt>
    <dt>Jellyfin - Media server</dt>
    <dt>Nginx Proxy mananger - Reverse Proxy</dt>
    <dt>Opencode - Local Agentic Agent</dt>
    <dt>SpeedTest - SpeedTest monitoring</dt>
    <dt>UptimeKuma - Uptime Monitoring</dt>
    <dt>VaultWarden - Password Manager</dt>

# OPNSense

OPNSense if my new service that runs and manage all my firewall rules, acts as my gateway router and manages my VLAN configuration. Up until know, I was just letting my ISP handle the networking end of my server but decided I wanted to learn in depth on how it works and how systems communicates with each other. I was looking at other options like PFsense but settled with OPNsense due to it's open source, no paywall and more frequent updates. I fully set up my VLAN configuration and fully configured firewall rules to not allow inter-vlan communication, segment out my network and safeguard my Server Infrastructure VLAN from the rest.

# Omada

I integrated 2 Omada EAP 650 AP due to it's ability to route per VLAN configuration. Now I have two nodes one in my main office and one in the living space to achieve good bandwidht, reduce load for one AP and allow better coverage within the houehold. Decided to run Omada in an LXC container to avoide adding more hardware to my current stack since I wanted to keep everything lean and reduce cost to run a physical controler. 

# Homarr

A cetnralized dashboard that contains all my server, RSS feeds, weather feed and server's information. Main purpose is to keep all my items in one place clean and easy to access

# Jellyfin

Wanted to configure and manage my own Media server since I have a bunch of DVDs around my house. This was a big project for me since managing users, updates, media management and making sure it's up and running is a big task for someone starting out like me. However since I already configured monitoring tools like Uptime Kuma and WUD, I can keep it up and running so my family can watch movies we buy and own.

# NGINX Proxy Manager

Now the tie all factor. A proxy manager. For a while I was going into my server's URL by typing in the IP address and port number. Try to remember which was which was a task. Wanted to have a FQDN to access my server locally and have SSL certs as well without exposing to the internet. That is where I found NGINX Proxy Manager. Using DNS Challange from my Cloudflare domain I can keep my HomeLab private and still have SSL cert. With PiHole acting as my DNS Server, I update my DNS entry to make sure it knows where to point if I type something like monitor.homelab.com (not a real FQDN)

# Opencode 

Wanted to start testing and playing with Agentic AI models without breaking the bank. I deployed a fully local AI Agent to my server that runs on free model provided to Opencode. ** DISCLAIMER - I never run my API keys, secrets or anything to the free models since they use it to keep training models **

Future plan to fully discontinue Opencode and start playing with Claude Code to help me manage and upkeep my server 

# Speedtest

A speed test monitoring tool that runs speed test against my network every hour to make sure my internet is receiving adaquate speed, low latency and it feeds it to my dashboard for ease of access

# Uptimekuma 

Next up is Uptime Kuma. Now Portainer manages or centralizes my containers but it had one challange. Notifying me if something goes down. I needed a service that will notify me via a medium like Discord or SMTP. During my research I found Uptime Kuma. It was the top recommended container to handle notifications if something goes down. I love how I can utilize a combination of Uptime Kuma and Portainer. For example, if one service goes down, uptime kuma will send me a notification via Discord (easiest way to set up) then I go into Portainer and look over the affected container logs and troubleshoot the root cause.

# Vaultwarden

Trying to remember all my admin credentials and making sure each of them are unique and strong was a big challange. For a while I was storing them on a note app on my iPhone. However after a while I tought to myself, what if my phone goes down, lost or stolen. How am I going to log in if the passwords are random generated to keep them secure? The solution a password manager. Now I could had went to Lastpass or bitwarden, paid a subscription and have it hosting somewhere in the cloud. But due to recent breaches I was a bit weary. Sure nothing in the internet is ever safe but figured having a self hosting password manager was more secure since it's not exposed publicly. That is when I found Vaultwarden. A fork version of Bitwarden in which I use to manage all my password. What's neat about it, it integrates with Bitwarden so the browser extension and phone app will work flawlesly. One cool feature I use on both my phone's and wife's phone if we create an account and store new password, it will auto sync once we connect to our home network. Which checks my original criteria, simple, minimal and feature rich. Now I can't really showcase a screenshot of my Vaultwarden due to sensative passwords.

# Tailscale 

Wanted a solution to be able to share my service without making it publicly available and have more support for apps. Orginally I had settled with twingate and it worked wonderful but the amount of community support and maturity of Tailscale was the leading factor. So far I have my Cloudflair domain pointing at the Tailscale IP that binds to my NPM so it can redirect to the correct URL, still provide me a valid SSL cert.
