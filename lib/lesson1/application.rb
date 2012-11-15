require 'sinatra'
require 'erubis'
require "rack/contrib"
require "rack"

module Lesson1
  class Application < Sinatra::Application
    # Configuration
    set :public_folder, lambda { Lesson1.root_path.join('public').to_s }
    set :views, lambda { Lesson1.root_path.join('views').to_s }

    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    get '/' do
      @trust = Trust.new(env)
      @link = LinkParser.new(params[:url])######
      erb :index
    end

    post '/links' do
      @trust = Trust.new(env)
      @link = LinkParser.new(params[:url])
      if @trust.filled_out?
        if @link
          @link.parse!
          erb :links
        else
          @trust.msg = "<p>Please enter correct URI in form above</p>"
          erb :index
        end
      else
        @trust.msg = "<p>Please enter URI in form above</p>"
        erb :index
      end
    end

    get '/links' do
      @trust = Trust.new(env)
      erb :index
    end

    get '/contact' do
      @trust = Trust.new(env)
      erb :contact
    end

    post '/contact' do
      @trust = Trust.new(env)
      if @trust.filled_out?
        if @trust.valid_email?
          @email = Contact.new(params[:name], params[:email], params[:feedback])
          @email.send
          erb :contact_us
        else
          @trust.msg = "<p>Something wrong with your email<p>"
          erb :contact
        end
      else
        @trust.msg = "<p>Please fill all required fields<p>"
        erb :contact
      end
    end
  end
end