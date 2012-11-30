# -*- encoding: utf-8 -*-

require 'sinatra'
require 'erubis'
require "rack/contrib"
require "rack"
require 'omniauth-facebook'

SCOPE = 'email,read_stream'

module Lesson2
  class Application < Sinatra::Application
    # Configuration
    set :public_folder, lambda { Lesson2.root_path.join('public').to_s }
    set :views, lambda { Lesson2.root_path.join('views').to_s }
    set :protection, :except => :frame_options
    # Middleware
    use Rack::CommonLogger
    use Rack::Reloader

    use Rack::Session::Cookie

    use OmniAuth::Builder do
      provider :facebook, ENV['140247929457138'], ENV['87c868810882d3459873adcc0dff15ef'], :scope => SCOPE
    end

    get '/' do
    redirect '/auth/facebook'
    end

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
    
# client-side flow
  get '/client-side' do
    content_type 'text/html'
    # NOTE: when you enable cookie below in the FB.init call
    #       the GET request in the FB.login callback will send
    #       a signed request in a cookie back the OmniAuth callback
    #       which will parse out the authorization code and obtain
    #       the access_token. This will be the exact same access_token
    #       returned to the client in response.authResponse.accessToken.
    <<-END
      <html>
      <head>
        <title>Client-side Flow Example</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js" type="text/javascript"></script>
      </head>
      <body>
        <div id="fb-root"></div>

        <script type="text/javascript">
          window.fbAsyncInit = function() {
            FB.init({
              appId  : '#{ENV['APP_ID']}',
              status : true, // check login status
              cookie : true, // enable cookies to allow the server to access the session
              xfbml  : true  // parse XFBML
            });
          };

          (function(d) {
            var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
            js = d.createElement('script'); js.id = id; js.async = true;
            js.src = "//connect.facebook.net/en_US/all.js";
            d.getElementsByTagName('head')[0].appendChild(js);
          }(document));

          $(function() {
            $('a').click(function(e) {
              e.preventDefault();

              FB.login(function(response) {
                if (response.authResponse) {
                  $('#connect').html('Connected! Hitting OmniAuth callback (GET /auth/facebook/callback)...');

                  // since we have cookies enabled, this request will allow omniauth to parse
                  // out the auth code from the signed request in the fbsr_XXX cookie
                  $.getJSON('/auth/facebook/callback', function(json) {
                    $('#connect').html('Connected! Callback complete.');
                    $('#results').html(JSON.stringify(json));
                  });
                }
              }, { scope: '#{SCOPE}' });
            });
          });
        </script>

        <p id="connect">
          <a href="#">Connect to FB</a>
        </p>

        <p id="results" />
      </body>
      </html>
    END
  end

    # auth via FB canvas and signed request param
  post '/canvas/' do
    # we just redirect to /auth/facebook here which will parse the
    # signed_request FB sends us, asking for auth if the user has
    # not already granted access, or simply moving straight to the
    # callback where they have already granted access.
    #
    # we pass the state parameter which we can detect in our callback
    # to do custom rendering/redirection for the canvas app page
    redirect "/auth/facebook?signed_request=#{request.params['signed_request']}&state=canvas"
  end

  get '/auth/:provider/callback' do
    # we can do something special here is +state+ param is canvas
    # (see notes above in /canvas/ method for more details)
    content_type 'application/json'
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
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
      @todo = Todos.new
      @todo_list = @todo.list
      @admin = Admin.new
      @user_list = @admin.user_list
      erb :admin
    end

    post '/save_todo' do
      Todos.new.save(env['rack.request.form_hash']) #TODO filter user input
      #return env['rack.request.form_hash']['id'].to_s
    end

  end
end