module CustomHelpers
  def contrib_linker(contribString)
  #Helper turns Contributor name into link for contributor page
    if data.authors.include?(contribString)
      """<a href='/authors/#{contribString.parameterize}.html'>#{contribString}</a>"""
    else
      contribString
    end
  end
  def parseEventTitle(titleString)
  #Helper parses event title strings of the format "Talk with {Christine Burns}
  #and {Peter Tatchell}" to turn bracketed names into contributor links.

  #This regex may be overly broad, I've tested it for well formed simple cases
  #/queenp
    titleString.gsub(/\{[^\{]*\}/) {|author| contrib_linker(author[1..-1])}
  end
end
