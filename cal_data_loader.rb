#!/usr/bin/env ruby
# usage: cal_data_loader.rb [clean]
#  - clean clears contrib data file

require 'icalendar'
require 'yaml'

CONTRIB_REGEX = /\{[^\{]*\}/

ICALS = {"main-festival" => "ical/main.ics",
  "family-space" => "ical/family-space.ics",
  "theatre" => "ical/theatre.ics",
  "conference" => "ical/academic.ics"}

CONTRIB_FILE = "data/contribs.yml"

if ARGV[0] == "clean"
  File.open(CONTRIB_FILE, 'w') {|f| f.write ""}
else
  contribs = YAML::load_file(CONTRIB_FILE)

  contribs ||= {} #initialize with blank hash if YAML loads false

  ICALS.each do |file, ics|
    ical = Icalendar.parse(open(ics)).first
    ical.events.each do |event|
      contributors = event.description.scan(CONTRIB_REGEX)
      contributors.each do |contrib|
        contrib = contrib[1..-2]
        if !contribs.has_key?(contrib)
          #don't overwrite existing records
          #init new entry
          contribs[contrib] = {"bio" => nil,
                               "pic" => nil,
                               "urlname" => "TODO:script urlification",
                               "events" => event.uid.to_s}
        end
      end
    end
  end

  File.open(CONTRIB_FILE, 'w') {|f| f.write contribs.to_yaml } # save to file
end
