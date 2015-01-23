# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

# Middleman
gem 'middleman', :git => 'https://github.com/middleman/middleman.git', branch: 'v3-stable'
gem 'middleman-blog', :git => 'git://github.com/middleman/middleman-blog.git'
gem 'middleman-imagelb', :git => 'https://github.com/queenp/middleman-imagelb.git'
gem "middleman-favicon-maker", "~> 3.7"
gem "middleman-google-analytics"
gem "middleman-blog-authors"

# iCal stuff
gem "icalendar"

# Live-reloading plugin
gem "middleman-livereload"

# Post trimmer
gem "nokogiri"

# Typographic symbol correction
gem 'rubypants'

# For faster file watcher updates on Windows:
gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]

# Cross-templating language block fix for Ruby 1.8
platforms :mri_18 do
  gem "ruby18_source_location"
end

gem "middleman-gh-pages", :git => 'https://github.com/mehulkar/middleman-gh-pages.git', branch: 'patch-1'
