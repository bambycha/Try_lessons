require 'mysql2'
module Lesson2
	class Db_build
		def create
			connect = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "barfoo");
			results = Client.query(root_path.join('db', 'install.sql'))
		end
	end
end