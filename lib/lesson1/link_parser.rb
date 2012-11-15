require 'httparty'
require 'uri'

module Lesson1
  class LinkParser
    attr_reader :items

    def initialize(url)
      @url = url
      @items = {}
    end

    def init_url
        @p = URI.split(@url)
        @url = 'http://' + @url if @p[0].nil?
      end

    # Load and parse link
    def parse!
      init_url
      response = HTTParty.get(@url)
      pattern = /<a (href\s*=\s*(?:"([^"]*)"|'([^']*)'|([^'">\s]+)))*>(.*?)<\/a>/i
      body = response.body
      while pattern =~ body
        @uri=$1
        @obj=$+
        clean!
        @items["#{@uri}"] = @obj
        body = $~.post_match
      end
    end

    def clean!
      @uri.gsub!(/href\s*=\s*/i, "")
      @obj.gsub!(/(style\s*=\s*("([^"]*)"|'([^']*)'|([^'">\s]+)))*/i, "")
      @obj.gsub!(/<font\s+.*([^'">\s]+)*>/i, "")
    end
  end
end