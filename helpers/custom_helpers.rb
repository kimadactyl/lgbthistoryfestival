module CustomHelpers
  def contrib_linker(contribString)
    if data.authors.include?(contribString)
      """<a href='/authors/#{contribString.parameterize}.html'>#{contribString}</a>"""
    else
      contribString
    end
  end
  def parseEventTitle(titleString)
  #this regex may be overly broad, I've tested it for well formed simple cases
    titleString.gsub(/\{[^\{]*\}/) {|author| contrib_linker(author[1..-1])}
  end
end
