# -*- encoding: utf-8 -*-

require 'digest/sha1'

module Lesson2

		class Handle
		attr_reader :out

		class User < ActiveRecord::Base
		end

		def initialize(env)
			@env = env['rack.request.form_hash']
			@email = @env["email"]
			@fname = @env["fname"]
			@sname = @env["sname"]
			@passwd = Digest::SHA1.hexdigest @env["passwd"]
			@time = Time.now.getutc
		end

		def new_user
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