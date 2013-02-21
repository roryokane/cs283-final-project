# CS 283 Final Project: Better C Syntax

## About

This program compiles a certain C-like language to C code. It’s like a less ambitious version of [CoffeeScript](http://coffeescript.org/), for C instead of JavaScript. This program also provides a webserver, to fulfill the requirement for class of demonstrating networking skills.

## Usage

You can run this as a command-line tool or as a webserver.

To try out the command-line tool:

    echo "data" | bin/convert

To try the server, first, start the server:

	bin/server

then run this in a different terminal to convert "data" (requires [HTTPie](https://github.com/jkbr/httpie)):

	echo "data" | http GET localhost:4567/convert
