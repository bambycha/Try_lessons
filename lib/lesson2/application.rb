# -*- encoding: utf-8 -*-

require 'sinatra'
require 'erubis'
require "rack/contrib"
require "rack"

module Lesson2
  class Application < Sinatra::Application
    # Configuration
    set :public_folder, lambda { Lesson2.root_path.join('public').to_s }
    set :views, lambda { Lesson2.root_path.join('views').to_s }
    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    helpers do

      def protected!
        unless authorized?
          response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
          throw(:halt, [401, "Not authorized\n"])
        end
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
      end

    end

    get '/' do
      erb :index
    end

    post '/' do
      @hand = Login.new(env)
      erb :index
    end

    get '/signup' do
      erb :reg
    end

    post '/signup' do
      @trust = Trust.new(env)
      if @trust.filled_out?
        @signup = Handle.new(env)
        if @signup.new_user
          erb :new_user
        else
          @out = @signup.out
          erb :reg
        end
      else
        @out = "Будь-ласка заповніть всі необхідні поля."
        erb :reg
      end
    end

    get '/admin' do
      protected!
      erb :admin
    end

  end
end