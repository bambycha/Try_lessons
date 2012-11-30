require "active_record"
ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "localhost",
      :username => "todo_user",
      :password => "foobar",
      :database => "todo"
    )