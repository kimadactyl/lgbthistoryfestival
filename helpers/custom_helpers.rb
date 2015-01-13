module CustomHelpers
  def contrib_linker(contribString, dev=true)
  #Helper turns Contributor name into link for contributor page
    return contribString if dev # shortcut contributor page linking
                                # while contributor page index not set up
    if(data.contribs.include?(contribString) && !data.contribs[contribString].hide)
      contrib = data.contribs[contribString]
      """<a href='/speakers/#{contrib.urlname}.html'>#{contribString}</a>"""
    else
      contribString
    end
  end
  def parseEvent(eventText)
  #Helper parses event title strings of the format "Talk with {Christine Burns}
  #and {Peter Tatchell}" to turn bracketed names into contributor links.

  #This regex may be overly broad, I've tested it for well formed simple cases
  #/queenp
    eventText.gsub(/\{[^\{]*\}/) {|speaker| contrib_linker(speaker[1..-2])}
  end
  def contribs_AZ()
    #really just a low functionality stub
    #sort list of contributor data by contributor surname
    data.contribs.sort #_by {|key,_| key.split(" ")[-1].downcase}
  end
end
