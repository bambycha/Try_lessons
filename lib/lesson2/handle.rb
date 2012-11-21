# -*- encoding: utf-8 -*-

require "active_record"
require 'digest/sha1'

module Lesson2

		class Handle
		attr_reader :out

		ActiveRecord::Base.establish_connection(
		  :adapter  => "mysql2",
		  :host     => "localhost",
		  :username => "todo_user",
		  :password => "foobar",
		  :database => "todo"
		)

		def initialize(env)
			@env = env['rack.request.form_hash']
			@email = @env["email"]
			@fname = @env["fname"]
			@sname = @env["sname"]
			@passwd = Digest::SHA1.hexdigest @env["passwd"]
			@time = Time.now.getutc
		end

		class User < ActiveRecord::Base
		end

		def new_user
			#@user_var =  [@email , @fname , @sname , @passwd]
			# productproperty = ProductProperty.find_or_create_by_product_id(product.id) { |u| u.property_id => property_id, u.value => d[descname] } )
			@user = User.find_or_create_by_email(@email,
				:fname => @fname.to_s,
				:sname => @sname.to_s,
				:passwd => @passwd,
				:date => @time
				){@out = "Вітаємо! Ви успішно зареєстровані."}
			if @out.blank?
				@out = "Вибачте, користувач з e-mail адресою - '#{@email}' вже зареєстрований в системі."
				return false
			end
		end

	end

end

			# @user = User.new(
			# 	:email => @email.to_s,
			# 	:fname => @fname.to_s,
			# 	:sname => @sname.to_s,
			# 	:passwd => @passwd,
			# 	:date => @time
			# 	)