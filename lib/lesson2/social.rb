# -*- encoding: utf-8 -*-

module Lesson2

	class Social < Warden::Strategies::Base

		def valid?
			!(settings.out[:info][:email].blank?)
		end

		def authenticate!
	    	user = settings.out[:info][:email]
	  	end

	  	protected
	  		def auth_hash
	  			user
	  		end
	  
  	end

end