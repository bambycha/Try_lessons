# -*- encoding: utf-8 -*-

require 'sinatra'
require 'erubis'
require "rack/contrib"
require "rack"
require 'omniauth-facebook'
require 'warden'

module Lesson2
  
=begin

    helpers do###

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

    end###^
=end

class Application < Sinatra::Application
    # Configuration
    set :public_folder, lambda { Lesson2.root_path.join('public').to_s }
    set :views, lambda { Lesson2.root_path.join('views').to_s }
    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader
    use Rack::Session::Cookie, :secret => "foobar"

    helpers do
      def current_user
        warden.user
      end

      def warden
        env["warden"]
      end
    end
    ##
    configure do###
    set :out, 'hello world'
    end###^

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = FailureApp.new
    end

    Warden::Manager.serialize_into_session do |user|
      puts user.userid
      puts "nar"
    end

    Warden::Manager.serialize_from_session do |id|
      User.get(id)
      puts "warr"
    end

Warden::Strategies.add(:password) do
  def valid?
    puts '[INFO] password strategy valid?'
    params['username'] || params['password']
  end
  
  def authenticate!
    puts '[INFO] password strategy authenticate'
    #puts "param>>" + params['username'] + "|||" + params['password']
    u = Handle.authenticate(params['username'], params['password'])
    @out = u
    u.nil? ? fail!('Could not login in') : success!(u)
    #env['warden'].set_user(u)
  end
end

  class FailureApp
    def call(env)
      puts "fail!!!"
      uri = env['REQUEST_URI']
      puts "failure #{env['REQUEST_METHOD']} #{uri}"
    end
  end
##^


    get '/' do
      erb :index
    end

=begin
    post '/' do
      env['warden'].authenticate!
      #@hand = Login.new(env)
      erb :index
    end
=end


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
      #protected!
     # env['warden'].authenticate!
     puts "sone"
      redirect '/login' unless env['warden'].user#authenticate?#stored_in_session?#env['warden'].user#(:userid)
      @todo = Todos.new
      @todo_list = @todo.list
      @admin = Admin.new
      @user_list = @admin.user_list
      erb :admin
    end

    get '/login' do
      #@outs = 'puts >>' + env['warden'].user if !(env['warden'].user.nil?)
      erb :login
    end

    post '/login/?' do
      if env['warden'].authenticate(:password)
        redirect '/admin'
      else
        @outs = "User not found."
        erb :login
        #redirect '/login'
      end
    end

    post '/save_todo' do
      Todos.new.save(env['rack.request.form_hash']) #TODO filter user input
      #return env['rack.request.form_hash']['id'].to_s
    end

  get '/auth/:provider/callback' do
    settings.out = env['omniauth.auth']#[:info][:email]#MultiJson.encode(request.env)
    redirect '/admin'
  end

  get '/next' do
    #Warden::SessionSerializer.new(@env).store(settings.out)
    settings.out = Warden::SessionSerializer.new(@env).fetch(3)
    #settings.out = Handle.authenticate("2233965gmail.com", "foobar")
    erb :out
  end

  end

end