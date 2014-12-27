module CustomHelpers
  def contrib_linker(contribString)
  #Helper turns Contributor name into link for contributor page
    if(data.authors.include?(contribString) && !data.authors[contribString].hide)
      """<a href='/authors/#{contribString.parameterize}.html'>#{contribString}</a>"""
    else
      contribString
    end
  end
  def parseEvent(eventText)
  #Helper parses event title strings of the format "Talk with {Christine Burns}
  #and {Peter Tatchell}" to turn bracketed names into contributor links.

  #This regex may be overly broad, I've tested it for well formed simple cases
  #/queenp
    eventText.gsub(/\{[^\{]*\}/) {|author| contrib_linker(author[1..-2])}
  end
end
