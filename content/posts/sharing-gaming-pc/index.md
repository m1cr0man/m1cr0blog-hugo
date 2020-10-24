---
title: Sharing a Gaming Computer with VMs
date: 2020-10-24T18:00:00+01:00
Description: It's possible, but some companies are ruining the fun.
tags:
    - linux
    - gaming
mainimage: images/parts.jpg
---

With the current shortages on all computer parts world wide, the release of the next Nvidia series, and my personal decision to live at home until the end of the pandemic, I got the idea that maybe it was time to upgrade my computer.

My whole family is into gaming - well, my brother, dad and me that is. All the computers are in the same room, which makes for some interesting voice calls when the background noise includes [desperate attempts to plead innocent of murder](https://store.steampowered.com/app/945360/Among_Us/) and [attempting to coordinate a terrorist insurgency](https://store.steampowered.com/app/581320/Insurgency_Sandstorm/). Beyond the noise, one of the big issues with this is the power usage and heat generated from the 3 gaming computers, and occasionally the file server is on too, which contains ~2tb of our Steam games (more on that in another blog post).

I have been following the story of [VFIO](https://www.reddit.com/r/VFIO) passthrough for a while, and a few of my friends have been successfully gaming on a Windows VM on top of Linux since last year. I had bigger ideas though - what if I could run two gaming VMs on one PC?

Spoilers: This did not go well for reasons completely out of my control, which I will explain later in the article. I'm writing this blog post because it was a fun project and I spent a lot of weekends trying to get it to work for the games I wanted to play, and maybe it will help someone else.

## Why?

{{< sideimage "images/computer.jpg" "My computer in all its UV glory" >}}
Initially, my main motives were the power and cost savings, but I quickly realized that I wasn't going to save that much power or money (my brother would though!) if I included the GPU upgrades I wanted and how much power they consumed. However as I got into it there were some other major benefits.

Firstly, if Windows is installed in a VM there is no real need to do a system reload even if the underlying hardware changes. As anyone who has [modded a Bethesda game](https://www.sinitargaming.com/nv.html) will know, reinstalling some games can take days especially if you have a poor internet connection. Since I was setting up two identical VMs, this also meant I only needed to do one system install and then I could clone the filesystem to the other.

Speaking of the filesystem, I'm a huge fan of ZFS. There are some magic-tier benefits of using this as the backing store for the VMs. I initially built the VMs with 60gb disks on a 256gb SSD. You would expect the total storage usage of two Windows installs to be around 40gb or so, but since I was able to clone one install from the other, and I had compression enabled, the total space used to install both OSes came to under 15gb! With deduplication enabled, I was also able to save huge amounts of space between games installed on both VMs. I estimated that both VMs would end up with at least 150gb usable space on the 250gb SSD, including the space used for the Linux install.

With all this in mind, I was also going to compact our file server into this PC too. The Linux side of this host can be used for more than just running VMs. If I was to buy two 14tb HDDs I could migrate all of our server files onto it and I would be combining _three_ computers into one.

Despite all these benefits, I wasn't going to give up anything to move to a VM. If I couldn't get two screens and my sound card working, I was going to bail on the project. It would also be especially difficult to convince my brother to give up his PC if he had to make compromises too!

## How?

{{< sideimage "images/zfs.png" "ZFS storage usage is very low" >}}
I had to buy a few things to even get started on this project. The 256gb SSD was one - so that I didn't have to wipe the currently working Windows install I had. Next was buying a sufficient amount of RAM for 2 gamers and a Linux server to run all at once on my PC. I got 32gb to start with, but my motherboard has another 4 slots and I planned to go to 64gb if all went well. Lastly, I wanted more CPU threads. My chipset, the LGA2011-1, once was available with a mammoth 16 thread CPU - the [Xeon E5-2690](https://ark.intel.com/content/www/us/en/ark/products/64596/intel-xeon-processor-e5-2690-20m-cache-2-90-ghz-8-00-gt-s-intel-qpi.html). I managed to grab one of these off Ebay for much, much less than its original price tag.

Another thing about my chipset is that it has 40 PCIE 3.0 lanes. This means that I can run two graphics cards at full speed plus install PCIE sound cards and still have lanes left over. Unless you go for an LGA2066 or an AMD Threadripper, you're only looking at 20 or 16 lanes on any newer CPU which is lame. 60 euro for 40 lanes and 16 threads will certainly keep me happy!

In terms of the software install, I was of course going to use [NixOS](https://nixos.org/), which is now my go-to distribution for all things server related. Nothing beats declarative configuration management built into your OS, and this helped a lot throughout this process as I was able to go back and forth on VM configurations and not lose the working setups. If you're reading this looking for some config examples, my entire QEMU command lines are [in my nix-configs repo](https://github.com/m1cr0man/nix-configs/blob/a7257a8aea3ef885de0c45a006ef32c7181bac21/services/gamingvms.nix) as well as the rest of the system setup.

This would also be the first time I would use Windows 10 for my own system. I am on Windows 7 right now, for a number of reasons. One being my modded games install that I mentioned above, but also there's a lot of features in Windows 10 that I just don't like one bit. That said, Windows 7 is receiving less and less support from games and other applications so it was time to finally move on with this new setup.

## Nothing is ever easy

I started off getting one VM working (the one which would be my own gaming VM in the end), and getting Windows installed and operational through my Nvidia graphics card was actually quite easy. The Arch Wiki guide on VFIO and [the subreddit](https://www.reddit.com/r/VFIO) had all the resources I needed to get this running. Although, this success was short lived when I discovered my sound card wasn't working.

A while ago I picked up a Creative X-Fi Titanium from Ebay. I play Battlefield 2142 and some other older games a lot and they use the EAX sound system and have some unique sound settings for X-Fi cards that makes the sound amazing. Naturally, I installed the Creative sound card driver when setting up the VM, which immediately caused it to freeze for 2 minutes, and thereafter play no sound at all.

It took me 2 weekends and a [desperate Reddit post](https://www.reddit.com/r/VFIO/comments/ixnmb2/problems_passing_through_sound_card_on_windows/) to find a solution to this. I tried strace-ing the VM to see what syscalls were being used during the freeze, I messed around with the PCI device config on the Linux side to see what I could do. Eventually I discovered that the sound card worked just fine in a Linux VM, and it worked fine up until I installed the Creative driver, but after that it would take a full system reboot to get it working again which really tripped me up. Debugging on the Windows side proved too difficult for me as [it looked like](https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/wpp-software-tracing) I was going to need a second Windows machine running Visual Studio to get anything done. I settled on using the Windows default sound card driver which did get me 24 bit audio but did not get me EAX. This was the sort of compromise I was hoping I wouldn't need to make with the VM, but I was hopeful it would still pay off beyond this.

Once I had one VM running I cloned the Nix config and cloned the ZFS volume, and I had the second running in a matter of minutes. There were no problems running the second VM through the motherboard's sound card. Installing Steam, Discord, a web browser and some games also went smoothly.

On the third weekend of this project, I was finally able to sit down and install Rainbow Six Seige for some actual gaming. I gathered my usual squad and we got so far as getting into a match.

Then I got kicked.

## This Means War

{{< sideimage "images/kickmessage.png" "It is over Lucas, BattlEye has the high ground" >}}
It didn't take me long to discover [a Youtube video](https://www.youtube.com/watch?v=vXkuyeYaTro) and [a Reddit post](https://www.reddit.com/r/VFIO/comments/hsv8iz/battleye_just_ban_kvm_users_on_escape_from_tarkov/fydaa8y/) explaining that BattlEye has explicitly blacklisted VMs from playing online games. This anti-cheat is used by Rainbow Six and many other games I was looking forward to playing, and searching around I found that most other anti cheats had a similar system in place. I was able to find instruction on bypassing these checks but it involved doing stuff like patching the kernel and editing hardware IDs for devices, which I was not keen to do. Not only would this be difficult to do and hard to maintain, the anti cheats could simply [update their checks](https://www.reddit.com/r/VFIO/comments/i1aqrz/regarding_the_vm_spoofing/) at any time and start looking at something new, bringing me back to square one.

I want to believe that there is another solution here. The problem at its core is that the anti cheats cannot check for tampering on the hypervisor side, nor do they have the business case to implement such a system. I think if VM gaming is ever to become a viable option, the VFIO community or similar would need to offer up something to them which would validate their system as not being tampered with. I'm not even sure how this would work - a verifiable memory lock of sorts? Binary signing? It really depends on what they want - baring in mind that the concept of client-side anti cheat is pretty flawed anyway. Hell, I would even buy a "VM License" from BattlEye if such a thing existed just to make this setup work, and I can imagine the decision makers would be happy to provide such a thing if it meant more money for them.

Although BattlEye has claimed that up to 90% of VM gamers were cheating, that's not to say that 90% of all cheaters use VMs. It's way too cumbersome and from what I saw in my dark search into the bypass methods, most people just crack the binary on Windows or do some weird driver magic and then get on with memory modifications. It's ridiculous that these systems are dictating how I play the games I paid for, making assumptions about my system and deciding that it will be worth the bad PR and small user base impact.

## Mothballed, for now

With no way to play modern titles in a VM reliably, without being wrongly accused as a cheater by unfeeling software and its business logic, I had to drop the project. If my brother and I were playing less high budget games maybe it would be viable, as it's only games with these anti cheats that are actually an issue. That said, almost every game without weird anti cheat works on Wine now, which has opened the door to a new project that I am now half way through and will blog in the near future (read: Not 2 years again).

I think there would be some real interest in VM gaming right now if it was feasible. Getting a 16 or 32 thread CPU and 32gb of ram is not too hard, especially if you're splitting the cost with someone else. It also expands the budget for larger system builds, which personally I was looking forward to. My plan was to water cool two GPUs and my CPU if all this went well, and I would be sharing one very cool computer. Now, I guess I'll stick with my 8 year old chipset until it dies and save some money!
