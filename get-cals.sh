#!/bin/sh
curl https://www.google.com/calendar/ical/kim%40lgbthistoryfestival.org/public/basic.ics > ./ical/main.ics
curl https://www.google.com/calendar/ical/lgbthistoryfestival.org_0gc2nrd6ls6fjbuuf8icuju3ag%40group.calendar.google.com/public/basic.ics > ./ical/family-space.ics
curl https://www.google.com/calendar/ical/lgbthistoryfestival.org_qtra32a7f24jpc75ghjuffeops%40group.calendar.google.com/public/basic.ics > ./ical/films.ics
curl https://www.google.com/calendar/ical/lgbthistoryfestival.org_ijgln6bmp4th9sg6stditdv7ok%40group.calendar.google.com/public/basic.ics > ./ical/theatre.ics
curl https://www.google.com/calendar/ical/lgbthistoryfestival.org_8mtrc289k99o4g90rc9cgce3io%40group.calendar.google.com/public/basic.ics > ./ical/academic.ics

./cal_data_loader.rb
