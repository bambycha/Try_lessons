# -*- encoding: utf-8 -*-
require "rack"

module Lesson2
	class Trust
		attr_accessor :msg

		def initialize(env)
			@form_vars = env['rack.request.form_hash']
			@msg = ""
			@address = env['rack.request.form_hash']
			#@form_vars = {:name=>"", :email=>"s", :feedback=>"s"} 
			@field_bool=[]
			@field_all=true
			@p
		end

		def filled_out?							#Перевірка заповненості полів
			@form_vars.each do |key, value|	
				if ((!key)||(value == "")||(value == " "))
					@field_bool << false
				else
					@field_bool << true
				end
			end
			@field_bool.each do |key|
			@field_all= key && @field_all
			end
		return @field_all
		end

		def valid_email?
			if @address["email"] =~ /[A-Za-z0-9\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-\.]+/
				@address.untaint
				return 0
			else
				return nil
			end
		end

	end
end