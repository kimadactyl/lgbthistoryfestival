#!/usr/bin/env ruby

require 'icalendar'
require 'csv'
require 'yaml'

DEFAULT_OUTFILE = "calendar.csv"

TICKETDATA = YAML.load_file("../data/ticketed.yml")
EVENTDATA = YAML.load_file("../data/events.yml")

def parseICS filename
  if File.exist? filename
    outfile = (File.join (File.dirname filename), (File.basename filename, ".ics")) + ".csv"
    return Icalendar.parse(open(filename)).first, outfile
  else
    puts "#{filename} not found"
    exit 0
  end
end

def init_outfile file
  # add line of headers
  file.puts "Calname, Summary, Start, End, TStamp, Location, Ticketed, Description"
end

def event2csvrow event, filename
  row = []
  row.push File.basename(filename, '.ics')
  row.push event.summary
  row.push event.dtstart
  row.push event.dtend
  row.push event.dtstamp
  row.push event.location
  if EVENTDATA[event.uid] && TICKETDATA[EVENTDATA[event.uid]]
    row.push TICKETDATA[EVENTDATA[event.uid]]['cost']
  else
    row.push "No"
  end
  row.push event.description
  return row.to_csv
end

def main
  if ARGV.length == 0
    puts "Usage: ics2csv.rb [icalfile(s)]..."
  else
    csv = File.open("./"+DEFAULT_OUTFILE, 'wb')
    init_outfile csv
    ARGV.each do |filename|
      cal = Icalendar.parse(open(filename)).first
      cal.events.each do |event|
        csv.puts (event2csvrow event, filename)
      end
    end
  end
end

if $0 == __FILE__
  main
end
