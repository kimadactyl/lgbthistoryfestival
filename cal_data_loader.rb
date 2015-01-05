#!/usr/bin/env ruby
# usage: cal_data_loader.rb [clean]
#  - clean clears contributor data file

require 'icalendar'
require 'yaml'

CONTRIB_REGEX = /\{[^\{]*\}/

ICALS = {"main-festival" => "ical/main.ics",
  "family-space" => "ical/family-space.ics",
  "theatre" => "ical/theatre.ics",
  "conference" => "ical/academic.ics"}

CONTRIB_FILE = "data/contribs.yml"

def parameterize string
  #avoiding requiring rails for such a simple script, for now
  string.downcase.split(" ").join("-")
end

if ARGV[0] == "clean"
  File.open(CONTRIB_FILE, 'w') {|f| f.write ""}
else
  contribs = YAML::load_file(CONTRIB_FILE)

  contribs ||= {} #initialize with blank hash if YAML loads false

  ICALS.each do |file, ics|
    ical = Icalendar.parse(open(ics)).first
    ical.events.each do |event|
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
end
