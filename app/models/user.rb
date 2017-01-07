class User < ActiveRecord::Base
	has_many :expertises

	def get_expertises(url = 'http://www.w3schools.com/tags/tag_hn.asp', id)
		mechanize_browser = Mechanize.new { |agent|
		  agent.user_agent_alias = 'Mac Safari'
		}

		doc = Nokogiri::HTML(mechanize_browser.get(url).body, "UTF-8")
		doc.xpath('//h1', '//h2', '//h3').each do |node|
			create_expertise(node.text, id)
		end
	end

	def create_expertise(description, id)
		Expertise.create(user_id: id.to_i, description: description)
	end

	def get_shortened_url(url)
		Bitly.new(ENV['BITLY_USERNAME'], ENV['BITLY_API_KEY']).shorten(url).short_url
	end
end
