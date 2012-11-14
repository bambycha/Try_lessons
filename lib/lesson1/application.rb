require 'sinatra'
require 'erubis'
require "rack/contrib"

module Lesson1
  class Application < Sinatra::Application
    # Configuration
    set :public_folder, lambda { Lesson1.root_path.join('public').to_s }
    set :views, lambda { Lesson1.root_path.join('views').to_s }

    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    get '/' do
      erb :index
    end

    post '/links' do
      @link = LinkParser.new(params[:url])
      @link.parse!

      erb :links
    end

    get '/links' do
      erb :index
    end

    get '/contact' do
      erb :contact
    end

    post '/contact' do
      @email = Contact.new(params[:name], params[:email], params[:feedback])
      @email.send
      erb :contact_us
    end
  end
end