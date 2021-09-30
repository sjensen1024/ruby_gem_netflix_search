class NetflixSearch::Connector
	attr_reader :mechanize_object

	def initialize(creds, mechanize_config)
		mechanize_object = Mechanize.new
		mechanize_object.get(mechanize_config["login_url"]) do |page|
			success = connector_login(page, creds, mechanize_config)
			raise "Error in NetflixSearch::Connector#initialize: could not establish connection successfully." unless success
		end
		@mechanize_object = mechanize_object
	end

	private

	def connector_login(page, creds, mechanize_config)
		success = false
		raise_if_required_creds_missing(creds)
		login_form = page.forms[mechanize_config["login_form_index"]]
		login_form.fields.select{ |i| i.name == mechanize_config["login_form_email_field_name"] }.first.value = creds["email"]
		login_form.fields.select{ |i| i.name == mechanize_config["login_form_password_field_name"] }.first.value = creds["password"]
		sleep(mechanize_config["login_form_pre_submit_sleep"])
		new_page = login_form.submit
		sleep(mechanize_config["login_form_post_submit_sleep"])
		profile_links = new_page.links.select{ |i| i.text.strip.downcase == creds["profile"].downcase }
		if profile_links.any?
			profile_links.first.click
			success = true
			sleep(mechanize_config["profile_select_sleep"])
		end
		success
	end

	def raise_if_required_creds_missing(creds)
		if creds["email"].blank? || creds["password"].blank? || creds["profile"].blank?
			raise "Error: creds must include email, password, and profile."
		end
	end

end