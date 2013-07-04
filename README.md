# CS 283 Final Project: Better C Syntax

## About

This program compiles a certain C-like language to C code. It’s like a less ambitious version of [CoffeeScript](http://coffeescript.org/), for C instead of JavaScript. This program also provides a webserver, to fulfill the requirement for class of demonstrating networking skills.

The language makes these basic changes to C’s syntax:

- no semicolons at ends of lines
- use indentation instead of braces `{}` for blocks
- if, while, and for loops have no parentheses around their conditions

## Installation

Prerequisites:

- [Ruby](http://www.ruby-lang.org/) 2.0
    - as specified in the `.rbenv-version` file, for use with [rbenv](https://github.com/sstephenson/rbenv)
- [Bundler](http://gembundler.com/) (for Ruby)
    - just `gem install bundler` if you don’t have it

Installation steps:

- `cd` to directory to store project in
- `git clone git://github.com/roryokane/cs283-final-project.git`
- `cd cs283-final-project`
- `bundle install` to install gem dependencies

## Usage

You can run this as a command-line tool or as a webserver.

To try out the command-line tool:

    echo "some_code()" | bin/convert

To use the command-line tool to process a `.betterc` file:

	bin/convert < my-file.betterc > my-file.c

To try the server, first, start the server:

	bin/server

then run this in a different terminal (requires [HTTPie](https://github.com/jkbr/httpie)):

	echo "some_code()" | http GET localhost:4567/convert

### While editing this project

To run all unit tests, run `rake test`.

## Project status

I wrote down the wrong due date for this project and was forced to complete it hurriedly at the last minute. Thus, the code is a hack instead of the elegant parser I had planned. The program still basically works as planned – it successfully compiles `test/test-cases/general-level-2.betterc` to `general-level-2.c` in that directory – but it handles only the most common edge cases.

This program successfully avoids adding semicolons to comment lines and lines with preprocessor directives. But it sometimes adds semicolons in the middle of multi-line parenthesized expressions. It only recognizes tabs for indentation, not spaces. It will do its extra processing in the middle of multiline comments. Thus, this program is currently a prototype plus a skeleton for a robust version – I do not recommend using it as is.

This assignment is over, and I am no longer required to work on it. I will probably continue working on a compiler like this some time, but in a different repo. My next step for the main code will be to write the robust parser I sketch in some of the files in `doc/`. (But my actual next step might be cleaning up the test cases more.)
