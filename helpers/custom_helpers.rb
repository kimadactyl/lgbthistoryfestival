module CustomHelpers
  def contrib_linker(contribString)
  #Helper turns Contributor name into link for contributor page
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
end
