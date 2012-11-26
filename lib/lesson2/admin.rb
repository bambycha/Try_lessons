# -*- encoding: utf-8 -*-

 module Lesson2

	class Admin
		attr_reader 

		ActiveRecord::Base.establish_connection(
		  :adapter  => "mysql2",
		  :host     => "localhost",
		  :username => "todo_user",
		  :password => "foobar",
		  :database => "todo"
		)

		class User < ActiveRecord::Base
		end

		def user_list
			@user_list = User.select("fname, sname").all
			@user_list = ["Add some users first"] if @user_list.blank?
			return @user_list
		end

	end

end