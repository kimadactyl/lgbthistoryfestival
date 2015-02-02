#!/usr/bin/env ruby

require 'icalendar'
require 'csv'
#require 'yaml'

DEFAULT_OUTFILE = "calendar.csv"

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
  file.puts "Summary, Start, End, TStamp, Location, Description"
end

def event2csvrow event
  row = []
  row.push event.summary
  row.push event.dtstart
  row.push event.dtend
  row.push event.dtstamp
  row.push event.location
  row.push event.description
  return row.to_csv
end

def main
  if ARGV.length == 0
    puts "Usage: ics2csv.rb [icalfile(s)]..."
  else
    csv = File.open("./"+DEFAULT_OUTFILE, 'wb')
    ARGV.each do |filename|
      cal = Icalendar.parse(open(filename)).first
      cal.events.each do |event|
        csv.puts event2csvrow event
      end
    end
  end
end

if $0 == __FILE__
  main
end
