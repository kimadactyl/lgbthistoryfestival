require 'icalendar'
module FestivalCalendar
  # Constant, accessible from any page/layout as FestivalCalendar::DAYS
  DAYS = {  "Thursday" => Time.new(2015,2,12),
            "Friday" => Time.new(2015,2,13),
            "Saturday" => Time.new(2015,2,14),
            "Sunday" => Time.new(2015,2,15) }

  class CalendarSorter

    def initialize(url_array)
      @cals = []
      # Load and sort the array
      url_array.each do |key,url|
        @cals << Icalendar.parse(open(url)).first
      end
      @cals.each do |cal|
        cal.events.sort! { |a,b| a.dtstart <=> b.dtstart }
      end
    end

    def get_start_times(start)
      # Tell us all the possible event starting times
      t = []
      @cals.each do |cal|
        t += cal.events { |a| a.dtstart.to_s }
      end
      t.uniq! { |x| x.dtstart.to_s}
      t.sort! { |a,b| a.dtstart <=> b.dtstart }
      t.uniq.select { |a| a.dtstart.between?(start, start + 24.hours) }
    end

    def get_events(time)
      # Get all the.events for a given time
      e = {}
      @cals.each do |cal|
        e[cal.x_wr_calname] = cal.events.select { |a| a.dtstart == time.dtstart }
      end
      e
    end

    def [] (key)
      #TODO: Get calendar events by key
    end

  end

  # Again, constant, accessible from any page/layout as FestivalCalendar::POPULAR
  POPULAR = CalendarSorter.new({
              "Main Festival" => "ical/main.ics",
              "Family Space" => "ical/family-space.ics",
              "Films" => "ical/films.ics",
              "Theatre" => "ical/theatre.ics",
              "Conference" => "ical/academic.ics"})
end
