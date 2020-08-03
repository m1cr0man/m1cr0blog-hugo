---
title: I Restored a 26 Year Old Printer
date: 2016-09-16T12:00:00+01:00
Description: A printer from a time long before economic engineering.
tags:
    - ti
    - hardware
    - vintage
    - printers
mainimage: images/IMG_20160909_174036.jpg
---

Before I even start, I need to explain something. To me, old computer equipment is on par with classic cars. It is a fragment of the world that it was born from. Some of the things that have been created in the past are worth keeping because the way they were built and designed will never be done (or in some cases, achieved) again.

I also have an irrational love for all things Texas Instruments (specifically their 90s IT equipment). I have a few of their laptops which I'll do some posts about some time.

## History & Specs

{{< sideimage "images/IMG_20160903_145854_cropped.jpg" "Pre cleaning" >}}
Meet the Texas Instruments Microlaser Plus. This little A4 printer was built in 1990, and probably set the design standard for laser printers from then on. With its single motor engine, it can pump out a whole *NINE* pages per minute! You can feed paper in either the normal way, through the somewhat finicky paper tray, or manually one page at a time through the slot above it.

TI had a habit of outsourcing production at this time. Despite having a motherboard of 90% TI chips, the printer has the same running gear as a Sharp JX-9500 from the same era. As a result, it's remarkably easy to get ink cartridges and opc drums! I have a couple of these Sharp printers too which I will look into at another date, because they are in much worse shape..and they aren't TI.

This particular printer has 2.5 MILLION bytes (you've got to make it sound big when it's [$300 PER MB](https://books.google.ie/books?id=wEufoGXlUxUC&pg=PT266&lpg=PT266&dq=sharp+printer+jx+95XX&source=bl&ots=ZaSQjJ07nb&sig=tv9TObzDqIOrqlDKvupZenRbh9Y&hl=en&sa=X&ved=0ahUKEwj1tvzbyJHPAhXJK8AKHdrVAtYQ6AEIKDAC#v=onepage&q=sharp%20printer%20jx%2095XX&f=false)) of RAM, and rare Postscript emulation. However, it emulates a HP Laserjet II by standard because writing drivers and firmware back in the day was only for the rich kids.

The main connectivity method for this printer is LPT, but it does have an RS232 port on the back aswell. There are a few gaps on the left hand side for "MicroCartridges", all of which are empty. They would be filled with plugin (not plug and play! The manual says it must be switched off before installation) modules that add features such as AppleTalk, extra Postscript fonts or a serial port if you were unfortunate enough to get a base model.

One thing this printer has which is now uncommon on laserjets is a straight-through paper path. It means that it can, effectively, print on anything that fits through the slot. It does not need to curl it back and out the top of the printer, but instead can pass it straight out the back if the cover is open.

## Quirks, Quirks Everywhere

{{< sideimage "images/IMG_20160909_122040.jpg" "Clam shell design, kind of like a truck" >}}
There's a lot of weird things going on in this printer. The first thing you probably notice is that it looks like there's something missing in the manual feed tray. This is sort of correct, there was a cumbersome addon envelope feeder, which added another 20cm or so to the front of the printer. The problem was that, well, it fed envelopes, and nothing else. As a result most people left it in the box and threw it away.

Another thing is...the "help" button. It's weird because these have disappeared in favour of the RTFM rule and software-based help. This is far more helpful however, upon pressing it three things are printed. The first is a flowchart showing how to navigate its LCD interface. The second is a supply status page, and the third is a configuration information sheet.

Mechanically, this printer is an odd ball all around. It's almost as if some (European) truck designer lost his job and ended up working at TI to design this instead. See, much like a truck, half the printer's components are on a hinge, and when you press the big "OPEN" button on the top of the printer, it splits in half exposing everything. You can change all the consumables minus the rollers without breaking the printer into 100 pieces.

Oh and the consumables! I had to get a middle aged man from the era (aka my dad) to explain what the fluffy pad on top of the fuser was - a cleaning pad! Seriously this thing is 26 years old and it's printing markless paper, all due to this little pad. If you flip it around to the dirty side (because the fuser rolls a certain direction) it's instantly clear how much of a difference it makes. Everything else is pretty standard, apart from the official refill kits and "reset fuse" (because back then you counted how many pages were left, not calculated!).

## Restoration & Operation

{{< sideimage "images/IMG_20160909_123128.jpg" "Plastic hates sunlight" >}}
The printer, after 26 years and 32,000 pages, is printing fine, and is mechanically almost new. I salvaged the rollers off a donor printer (Rest In Pieces) that had a dead motherboard and PSU so it picks up paper fine now. The problem is, the interface technology has changed a lot.

Powering up the printer was interesting. It's single motor runs for a few seconds whilst the controller goes through a "Self Test" phase. The one fan which cools the unit never goes off, because the fuser heater never turns off either. Energy efficiency definitely wasn't on their list of priorities it seems, but yet the laser prism motor (which sounds exactly like an old hard disk) spins down after a while.

If there's any errors during printing, it lets off a quite loud one-shot beep. Whether it's "Fuser Meltdown" or "No paper" you have the same notification. When I powered it up for the first time I thought something had gone *horribly* wrong but it was actually fine.

## Drivers

{{< sideimage "images/IMG_20160909_170213.jpg" "Almost assembled" >}}
This thing uses either serial or parallel to connect to things. Luckily, I found an LPT to USB converter and was able to get the printer running fine on Windows under HPII emulation mode. But that's not good enough for me.

For university, to use the printer on my laptop, I will need to get it working on a Cups printing server. For some reason, the HPII driver for Cups from foomatic doesn't send a "formfeed" character, and you have to press the button on the printer to get it to print it's current buffer. If you send another job, the printer does print the last job, so it's just a case of not getting the final command to print.

My original plan from this point was to attempt to write my own drivers. I set off trying to find the original MS DOS drivers mentioned in the user manual, but I found something WAY better. Postscript may be the best standard ever created, and Adobe are legends for keeping [every Texas Instruments PPD file](http://www.adobe.com/support/downloads/detail.jsp?ftpID=444) on record on their site!

I whipped out my laptop, loaded the file into cups and __it printed__!

Nothing. Just a blank page.

I am so close! What I'm going to do is compare the HP Laserjet II driver that works with the pseudo-official one and see why this is happening. From some quick Googling, it looks like the driver straight up doesn't encode the data right. Keep an eye on my [Twitter](https://twitter.com/m1cr0m4n) for updates on this. Oh, and there's more vintage hardware where this came from!
