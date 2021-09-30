Gem::Specification.new do |s|
  s.name        = 'netflix_search'
  s.license		  = "MIT"
  s.version     = '0.0.1'
  s.date        = '2021-09-29'
  s.summary		  = "This gem allows you to perform searches on Netflix."
  s.description = "An unlicensed, made-for-fun gem that will allow you to search for titles on Netflix. Utilizes Mechanize."
  s.authors     = ["Steve Jensen"]
  s.files       = Dir.glob(["lib/*", "lib/netflix_search/*", "lib/config/*"])
  s.homepage	  = "https://github.com/sjensen1024/ruby_gem_netflix_search"
  s.add_dependency "mechanize", "~> 2.8.1"
  s.add_dependency "activesupport", "~> 6.0.3"
  s.add_dependency "yaml", "~> 0.1.0"
end