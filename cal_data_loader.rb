#!/usr/bin/env ruby
# usage: cal_data_loader.rb [clean]
#  - clean clears contributor data file
#  - warning, highly destructive, will destroy any manual additions
#  - only exists to make development easier for the time being

require 'icalendar'
require 'yaml'

CONTRIB_REGEX = /\{[^\{]*\}/

ICALS = {"main-festival" => "ical/main.ics",
  "family-space" => "ical/family-space.ics",
  "theatre" => "ical/theatre.ics",
  "fringe" => "ical/fringe.ics",
  "conference" => "ical/academic.ics",
  "fringe" => "ical/fringe.ics"}

CONTRIB_FILE = "data/contribs.yml"
EVENTS_FILE = "data/events.yml"

def parameterize string, inc=false
  #avoiding requiring rails for such a simple script, for now
  string.gsub!(/[^\w\s\d]/,"")
  string = string.downcase.split(" ").join("-")
  string = string[0..40] #truncate for usefulness
  if inc
    string + inc
  else
    string
  end
end

if ARGV[0] == "clean"
  File.open(CONTRIB_FILE, 'w') {|f| f.write ""}
else
  contribs = YAML::load_file(CONTRIB_FILE)
  events = YAML::load_file(EVENTS_FILE)

  contribs ||= {} #initialize with blank hash if YAML loads false
  events ||= {}

  ICALS.each do |file, ics|
    ical = Icalendar.parse(open(ics)).first
    ical.events.each do |event|

      #might well become easier with an rdb
      if(!events.has_key?(event.uid.to_s))
        #new event
        #check for clashes with pretty url
        counter = 0

        clashes = events.select {|_,url| url == parameterize(event.summary)}
        while clashes.length > 0
          counter += 1
          clashes = events.select do |_,url|
            url == parameterize(event.summary, counter.to_s)
          end
        end
        #chuck counter on to avoid url collisions if necessary
        events[event.uid.to_s] = counter > 0 ? parameterize(event.summary,counter.to_s) : parameterize(event.summary)
      end

      contributors = event.description.scan(CONTRIB_REGEX)
      contributors.each do |name|
        name = name[1..-2] # cut off curly braces
        if !contribs.has_key?(name)
          #don't overwrite existing records
          #init new entry
          contribs[name] = {"bio" => "",
                               "pic" => "",
                               "urlname" => parameterize(name),
                               "events" => [event.uid.to_s]}
        elsif !contribs[name]["events"].include?(event.uid)
          #add event to existing entry
          contribs[name]["events"].push(event.uid.to_s)
        end
      end
    end
  end

  File.open(CONTRIB_FILE, 'w') {|f| f.write contribs.to_yaml } # save to file
  File.open(EVENTS_FILE, 'w') {|f| f.write events.to_yaml }
end
