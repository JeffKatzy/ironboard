module Adapters

	class GiphyClient
		def connection
			@connection = Adapters::GiphyConnection.new
		end

		def find_by_tag(tag_name)
			results = connection.query(tag_name)
			random_gif = results.data.sample
			# Ideally we store this in an object, even if it is a view object
			"https://media.giphy.com/media/#{random_gif.id}/giphy.gif"
		end

	end

end