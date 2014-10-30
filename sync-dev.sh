#!/bin/sh
middleman build
rsync -avze "ssh" ./build/ daresbalat@alliscalm.net:/home/daresbalat/lgbthistoryfestival.org/dev/
