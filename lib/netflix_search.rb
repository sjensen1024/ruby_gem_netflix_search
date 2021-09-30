class NetflixSearch
	require 'rubygems'
	require 'mechanize'
	require 'active_support'
	require 'active_support/core_ext/object'
	require 'yaml'
	require 'netflix_search/connector'

	attr_reader :connector, :mechanize_config

	def initialize(creds, mechanize_config_yaml_path = (__dir__ + "/config/mechanize_config.yml"))
		@mechanize_config = YAML.load(File.read(mechanize_config_yaml_path))
		@connector = NetflixSearch::Connector.new(creds, @mechanize_config)
	end

	def search(search_term, number_of_results = 1)
		results = []
		link_xpath = @mechanize_config["search_result_xpath"]
		replace_term = @mechanize_config["search_result_xpath_replace"]
		link_title = @mechanize_config["search_result_title"]
		@connector.mechanize_object.get(formulate_search_url(search_term)) do |page|
			for i in 0 ... number_of_results
				indexed_xpath = link_xpath.gsub(replace_term, i.to_s)
				result_link = page.parser.xpath(indexed_xpath)
				if result_link.any? && result_link.first.attributes[link_title].present?
					results.push(result_link.first.attributes[link_title].value.to_s)
				end
			end
		end
		results
	end

	def search_get_first_result(search_term)
		results = search(search_term)
		results.any? ? results.first : nil
	end

	private

	def formulate_search_url(search_term)
		search_term = sanitize_search_term(search_term)
		search_url = @mechanize_config["search_url"]
		search_url_replace = @mechanize_config["search_url_replace"]
		return search_url.gsub(search_url_replace, search_term)
	end

	def sanitize_search_term(search_term)
		return search_term.chomp.gsub(" ", "%20").gsub('"',"").gsub("'","")
	end

end