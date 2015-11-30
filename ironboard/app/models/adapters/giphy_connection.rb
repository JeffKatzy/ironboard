module Adapters

	class GiphyConnection
		include HTTParty
# cool
		def initialize
			@connection = self.class
		end

		def query(query)
			results = @connection.get("http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=dc6zaTOxFJmzC")
			s_results = RecursiveOpenStruct.new(results, :recurse_over_arrays => true)
		end


	end

end