# Horologist
Horology—the art or science of measuring time.

### What is *Horologist*?
*Horologist* is a minimal CLI tool to mark points in time with a simple message.

### What is it useful for?
*Horologist* can be used for any timing-related tasks. For example, you can use it to calculate effort-times; or you could even replace your current time-tracking solution.

### What's the interface?
The interface is rather minimal:

- To mark a point in time:
```bash
horologist now "initial observations"
# ✓ initial observations
```

If you ommit the message, *Horologist* will use a unique random noun as identifier. This noun is also simple and easy to remember at the time of the future consumption of the data:
```bash
horologist now
# ✓ Point in time - plexus_myentericus
```

- To view the timeline:
```bash
horologist past

* 2016-02-22 21:19:55 +0100 - Point in time - free_pardon
* 2016-02-22 21:19:54 +0100 - Point in time - phytelephas
* 2016-02-22 21:19:52 +0100 - Point in time - blighia
* 2016-02-22 21:19:40 +0100 - Point in time - plexus_myentericus
* 2016-02-22 21:19:35 +0100 - initial observations
* 2016-02-22 21:19:30 +0100 - ✓ Horologist is ready
```

You can specify specific initial and/or ending time spans to filter the timeline results:
```bash
horologist past yesterday..today

horologist past "last month.."

horologist past "2011-03-31..2016-03-31"
```

### How can I install it?
Clone this repository and within its directory run the command `ruby horologist.rb now`. It will then install any missing dependencies and make a copy of itself into `/usr/local/bin/` for global user access. 

For easier typing, make sure `/usr/local/bin/` is in your *path*.

### Which are the dependencies?
Horologist uses the following Ruby Gems:
- chronic
- random-word

### Can I rename the excecutable?
Sure. If you find yourself getting tired of typing `horologist` all the time, just rename it or create an alias using the command you'd like: `alias h="horologist"`

### Disclaimer
Horologist is a side-project experiment in which I combined 3 initial conditions:

1. To test what can I programm in just a few hours: ~5 hours on its core.
2. To use a programming language with which I have zero experience: Ruby.
3. To build it on top of a software which is totally not intended for the project's purpose: Git.

### License
Horologist is open-sourced software licensed under the MIT license.

&copy; Jesus Leon

--

This is a [hackabit.org](https://hackabit.org) project — Go and hack a bit.
