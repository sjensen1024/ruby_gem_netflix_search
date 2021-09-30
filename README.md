# ruby_gem_netflix_search
An unlicensed, made-for-fun gem that will allow you to search for titles on Netflix. Utilizes Mechanize

## Important note before installing

Please be aware that this is an unofficial build and was not built in partnership with Netflix or any of its affiliates. This gem serves as a webscraping tool to perform basic Netflix searches utilizing Ruby objects. Because it uses webscraping and requires you to specify login credentials for Netflix, please be aware that if the Netflix site changes enough, that could cause this gem to stop working. This was made more as a personal, for-fun project than something to utilize widely in the community. This does not mean that you can't install it or use it, nor do I want to discourage anyone from playing around with it or contributing.


## What is this gem? Why would you want to use it?

When you initialize a NetflixSearch object with a creds hash passed in, it sets up a connection to Netflix using those credentials of username, password, and profile. Once the object is initialized, you can perform searches with it, with which you have to option to return any number of results.

As was mentioned in the note at the beginning of this readme file, this gem is more of a for-fun project and is not intended to be widely maintained or used. With that being said, you can utilize this gem to perform simple searches in the catalog of your Netflix subscription.


## How it works

The gem utilizes Mechanize to scrape the Netflix website for you. As with any tool that utilizes webscraping, this means that if the website changes, the way you scrape it may need to change. This type of thing is never 100% break-proof. However, one thing that we did to potentially combat this is manage the specific things that the webscraper looks for in a configuration file within the gem (lib/config/mechanize_config.yml). It also gives you the option to supply your own configurations. While not fool-proof, it is a more configuration-based way of handling the potential changes that could happen to the site and adds a bit more flexibility.


## Example usage

```
require 'netflix_search'
require 'active_support'
require 'active_support/core_ext/object'

creds = {"email" => (your email here), "password" => (your password here), "profile" => (your profile here)}
netflix_obj = NetflixSearch.new(creds)

# Search for "The Social Network" and get the first 10 results
puts netflix_obj.search("The Social Network", 10).inspect

# Search for "ferris bueller" and get the first 25 results
puts netflix_obj.search("ferris bueller", 25).inspect

# Get the first result when searching for "The Social Network"
puts netflix_obj.search_get_first_result("The Social Network").inspect

# Get the first result when searching for "ferris bueller"
puts netflix_obj.search_get_first_result("ferris bueller").inspect
```

## Things that may be added/updated beyond the initial commits:

- More specific instructions on configurations you can use in the gem
- More flexible configuration, in terms of:
  - More flexible ways to use Mechanize
  - Allowing you to specify configuration in more than one way (i.e. not just YAML, not just passing in a hash, etc.)
- A way to check for a maintained connection or close the connection. Currently, it just allows you to log in and search.
- Cleaner search term sanitization

