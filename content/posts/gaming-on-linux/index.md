---
title: Gaming On Linux - Not Just For Hipsters
date: 2018-12-23T12:00:00+01:00
Description: 2019 might be the golden year for Linux gaming
Tags:
    - linux
    - gaming
mainimage: images/breaking_glass.jpg
---
For the past 15 years I've been a very opinionated PC gamer, along with the rest of my family. However it's always been a pain in some shape or form to _be_ a PC gamer, be it with the constant software updates, the lack of first-party support, or just the general cost. I'm one of these people that has stuck to good old Windows 7 because a mobile UI on my gaming PC is what I imagine hell to be. I've had no problems thus far, but there are more and more 10-only games coming out by the day, and some of them are enticing an upgrade.

Fortunately, there has been a LOT of activity around Wine and Vulkan to get Windows games running on Linux, to the point where I scheduled some time this Christmas break to give it a shot. My goal was to run the few games I actually wanted to play (Elite Dangerous, Minecraft, Subnautica, Garry's Mod) on Linux on a spare computer before the 25th, whilst also proving to my family of gamers that it was time to "break the glass" and get away from the proprietary OS.

## By the way I tried to use Arch
{{< sideimage "images/2018-12-24-003401_1440x900_scrot.jpg" "Desktop" >}}

I don't think it's possible to ever finish installing Arch, you just get more things configured (and broken) over time. I started this week trying to set up a system with Steam installed and Linux compatible games running. It took a full day's work to get through the numerous issues I encountered, but I eventually had Garry's Mod launching, albeit with some weird error about `en_US.UTF8` not being available.

At that point, I wasn't at all happy with the setup. I had a very minimal i3, a very broken version of Steam with all sorts of rendering issues, and one native Linux game limping along. I installed LXDE so that I had a window manager that cooperated with the concept of full screen graphics applications, but even with my high tolerance for outdated looking UIs I still couldn't help but dislike the default theme. I spent a good few hours fixing that but it was still uncomfortable to use.

I tried setting up [Lutris](https://lutris.net) too. They recommend installing wine-staging which is no problem on Arch because you just grab the [wine-staging AUR package](https://aur.archlinux.org/packages/wine-staging-git/) and job done. However I still couldn't get it to launch any games due to all sorts of missing dependencies in Wine (and maybe due to my Donegal internet too).

When I realized I needed to install most 32 bit versions for everything I accepted defeat. It was going to be too much hassle to configure + maintain an Arch gaming install, and I'd never want to reload that machine. I took a night to think about it, then I broke up with Arch in the morning.

## Solus is new bae

Whilst I was browsing around on Lutris, Reddit, and some other sites I kept seeing mentions of this new Debian based distro with some real fancy window manager. With my lack of motivation to do configuration myself my requirements were now very different as to when I picked Arch. However, with the need for a very new version of Steam + Wine in order to play games I needed something that had either frequent updates or a way to easily update manually.

The Solus website looked very appealing. "Designed for Home Computing". Last time I read that I set up Mint on my granny's laptop, and I don't think she used it since. However something about the material design of its site and UI made me think it was at least worth a shot.

I downloaded the ISO, booted up a computer, and in about 10 minutes I had a running machine. This PC does have an SSD in it, but even so it took just 4 seconds to boot to the login screen! My mentality of it needing to be Arch to boot fast went right out the window.

I logged in and a lot of things were just working, which was great, but then again my expectations were very low coming from Arch. There was a remarkable lack of shit installed by default. LibreOffice is there but not GIMP, and there's only 1 video player instead of 4. As a result I didn't spend any time undoing defaults, which I had fully expected from a "home computing" distribution.

## Who Needs Terminals?

I got Steam and Proton installed again, this time with no hassle because I used the Solus Software Centre and it just worked. Whilst that was downloading I copied Garry's Mod over from another Windows computer on the network through the file manager because apparently it just supports CIFS out of the box. I launched that game no problem, so then I started looking at Lutris again.

I was under the impression that I was going to need Lutris to play basically anything that wasn't a Steam native Linux game. It turns out that is not entirely true. My next game goal was Elite Dangerous, so I copied it over the network too and Steam picked it up fine. Testing my luck I just hit "play" with the Steam Proton version set to the latest beta, but it did absolutely nothing. Then I tried launching it through Lutris. I got a bit suspicious when I saw the Steam install downloader pop up, and then I realized it was creating its own "prefix" for Steam Windows under Wine, ignoring the system version I had installed entirely.

So I wasn't going to use Lutris for Elite then, and I got a bit worried. If it didn't launch through Steam would it work at all? I searched around and saw lots of people trying to get it to work, and then I found [this Github issue](https://github.com/ValveSoftware/Proton/issues/150) which lead to [this forked repo release](https://github.com/redmcg/wine/releases/tag/ED_Proton_3.16-6_Beta). With that, I had the game running flawlessly in like 20 minutes, and I even [tweeted about it](https://twitter.com/m1cr0m4n/status/1076614809414782976).

Other than installing the ED Proton fork, I had no need for a terminal during this process. I call that a testament to this OS. Generally, I only need a terminal when something breaks or something is more easily/quickly done at the prompt. My point being that if you were a Windows gamer trying to justify the conversion, you can rest assured that there is no need for any prior knowledge of Linux, or maybe even computers, to pull this off.

## Real Work on Solus

{{< sideimage "images/Screenshot from 2018-12-24 01-20-04.jpg" "Solus" >}}

It's been so long since I used a "real" distro I can't really separate what is unique to Solus from the common features you get nowadays. Setting up my networking and audio was painless. It's Network Manager based networking with that regular GNOME GUI you see everywhere. You can control your audio volumes per-application from the pop out side bar in the UI. I noticed whilst I was installing all sorts of random stuff that the Solus not-a-start-menu was populating shortcuts and categories for everything. Also once I got the Nvidia driver installed everything like moving windows around was silky smooth. Honestly, I don't think I want to use i3 any more.

With this level of confidence, I even went and setup my browser, IRC client, and a bunch of other stuff I would only do if I was committed to an install. What I wanted to try next was remote desktop gaming using TurboVNC, and I immediately encountered a problem. TurboVNC wasn't in Solus' repositories so I was going to have to build it myself. I'm so glad I did.

Solus has a really nice YAML based system for developing packages. It does 90% of the work for you which is awesome. It will setup a build environment in a chroot, install dependencies, run commands, and generate a package all based on this one package.yaml. Their documentation on this setup is quite easy to follow, but I did pop into their IRC for a few questions.

I ended up building 3 packages for TVNC + its dependencies, and it didn't take too long. From talking to a few developers and package maintainers, I'm quite tempted to submit + maintain these packages for Solus too. This blog post isn't going to be about remote desktop gaming though so I'll leave that for another day.

## Convincing the Family

Over this weekend I played around 8 hours of Elite, whilst on Discord, on this really weirdly spec'd computer with an i3 2100 and a GTX 970. I had zero issues, both in setup and performance, and I spent way more time actually playing the games than I expected to.

When I mention the idea of using Linux to my brother, I always get an immediate no. "It's for geeks", "I can't code", "X won't run on it". I was able to prove him wrong on at least 2 of his points, but really it would be so much better if we all ran Linux. One of the biggest problems we have at the moment is that every time we make a significant hardware change to one of our computers, we have to reload the OS. We wouldn't have to do that if we were running Solus on all the PCs. Also, Windows 7 isn't exactly secure anymore. It hasn't got real updates in like 2 years now, and we have turned them off before that to avoid breaking some games relying on old DRM (read: Securom) technology.

I don't think it is going to take me much longer to convert every one given how much faster, simpler and prettier running a modern Linux distribution is. So long as I can prove that new and old games will work fine and continue to work when I'm not around I might be in for a chance of having a standardized boot image on all of our computers. This is appealing because living in Donegal you can't be doing any sort of updates whilst playing games online otherwise your ping will go through the roof. You still have to do updates at some point, the question is how many times do you have to do them.

I'll continue to test more games and work out a way I can easily deploy an entire Linux gaming setup to more computers. It is already exceptionally simple, but I need a turnkey solution to running Windows games on Steam that I can hand to people that have no idea what `ls` does.
