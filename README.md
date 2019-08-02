# Dire Wolf #

### Decoded Information from Radio Emissions for Windows Or Linux Fans ###

In the early days of Amateur Packet Radio, it was necessary to use an expensive “Terminal Node Controller” (TNC) with specialized hardware.  Those days are gone.  You can now get better results at lower cost by connecting your radio to the “soundcard” interface of a computer and using software to decode the signals.

Why settle for mediocre receive performance from a 1980's technology  TNC using an old modem chip?   Dire Wolf decodes over 1000 error-free frames from Track 2 of the [WA8LMF TNC Test CD](https://github.com/wb2osz/direwolf/tree/dev/doc/WA8LMF-TNC-Test-CD-Results.pdf), leaving all the hardware TNCs, and first generation "soundcard" modems, behind in the dust.

![](tnc-test-cd-results.png)

 
Dire Wolf is a modern software replacement for the old 1980's style TNC built with special hardware.

Without any additional software, it can perform as:

 - APRS GPS Tracker
 - Digipeater
 - Internet Gateway (IGate)
- [APRStt](http://www.aprs.org/aprstt.html) gateway


It can also be used as a virtual TNC for other applications such as [APRSIS32](http://aprsisce.wikidot.com/), [UI-View32](http://www.ui-view.net/), [Xastir](http://xastir.org/index.php/Main_Page), [APRS-TW](http://aprstw.blandranch.net/), [YAAC](http://www.ka2ddo.org/ka2ddo/YAAC.html), [UISS](http://users.belgacom.net/hamradio/uiss.htm), [Linux AX25](http://www.linux-ax25.org/wiki/Main_Page), [SARTrack](http://www.sartrack.co.nz/index.html), [RMS Express](http://www.winlink.org/RMSExpress), [BPQ32](http://www.cantab.net/users/john.wiseman/Documents/BPQ32.html), [Outpost PM](http://www.outpostpm.org/), and many others.

# Install Docker
```console
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```

# Install docker-compose
* (Debian)
```console
$ sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
$ chmod +x /usr/local/bin/docker-compose
```

* (Raspberry)
```console
$ sudo apt-get -y install python-setuptools
$ sudo easy_install pip && sudo pip install docker-compose
```

# Build and Run direwolf
```console
$ git clone https://github.com/f4hlv/direwolf-docker.git
$ cd direwolf-docker
```
Edit docker-compose.yml and run
```console
$ docker-compose up -d
```
## Volume
- `./direwolf.conf:/direwolf/direwolf.conf` Path to the direwolf.conf File

# Update
```console
$ docker-compose build --no-cache
$ docker-compose up -d
```

# docker-compose
```yml
version: '3'

services:
  direwolf:
    build:
      context: .
      dockerfile: Dockerfile.debian
    tty: true
    stdin_open: true
    container_name: direwolf
    volumes:
      - ./direwolf.conf:/direwolf/direwolf.conf
    devices:
      - /dev/snd:/dev/snd
      - /dev/gpiomem:/dev/gpiomem
    restart: unless-stopped
```
