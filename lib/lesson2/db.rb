module Lesson2
	class User < ActiveRecord::Base
		attr_reader :out

		def initialize(user_var)
			#@connect = Mysql2::Client.new(:host => "localhost", :username => "todo_user", :password => "foobar", :database => "todo")
			ActiveRecord::Base.establish_connection(
			  :adapter  => "mysql",
			  :host     => "localhost",
			  :username => "todo_user",
			  :password => "foobar",
			  :database => "todo"
			)		
			@user_var = user_var
		end

		def create_user
		#	if #@out = @connect.query("SELECT * FROM users WHERE email=#{@user_var[0].to_s}")
			#newuser = connect.query("@user_var")
			#@out = @user_var[0].to_s
		#end
		end
	end
end