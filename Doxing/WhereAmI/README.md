# Where Am I?
That's the question this script's going to answer! Its sooo cool.
* This little piece of shit will get in few seconds an fully Whois IP lookup.
* The motherfucker also will make an entire quick scan (IP/MAC [vendor]) of the network.
* Also, if you stay enough on the network (proportionally to its dimensions) it will make an agressive scan.

I'd recommend you to make an entry on the cron table, to make this script run every... hour?. I mean at the time, this script
is gonna write a bunch of garbage as, I haven't implemented an 'already scanned' recognicion but... anyway

### What you previously need
* curl (I think is installed by default on most Linux environments)
* whois (same here)
* nmap (So obvious it shouldn't be mentioned)
