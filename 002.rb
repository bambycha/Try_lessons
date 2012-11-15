	      require 'uri'
	      require 'httparty'
class Pop
	def initialize 
		 @url = "http://www.example.com:80/foo?bar=foo"
		end
	def foo
	      @p = URI.split(@url)
	      @url = 'http://' + @url if !@p[0]
	      response = HTTParty.get(@url)
	      rescue StandardError
	      	puts "Error"
	  end
	end

	@bar = Pop.new
	@bar.foo