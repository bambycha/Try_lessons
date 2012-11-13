require 'httparty'

module Lesson1
  class LinkParser
    attr_reader :items

    def initialize(url)
      @url = url
      @items = []
    end

    # Load and parse link
    def parse!
      response = HTTParty.get(@url)
      pattern = /<a.*<\/a>/
      pattern =~ response.body
      @items << $&
      while pattern =~ $~.post_match
        @items << $&
      end
    end
  end
end