# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

gem 'middleman', :git => 'https://github.com/middleman/middleman.git', branch: 'v3-stable'
gem 'middleman-thumbnailer', :git => 'https://github.com/nhemsley/middleman-thumbnailer.git'
gem "middleman-favicon-maker", "~> 3.7"
gem "middleman-google-analytics"

# Live-reloading plugin
gem "middleman-livereload"

# For faster file watcher updates on Windows:
gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]

# Cross-templating language block fix for Ruby 1.8
platforms :mri_18 do
  gem "ruby18_source_location"
end