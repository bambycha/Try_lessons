require "active_record"

ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "localhost",
      :username => "todo_user",
      :password => "foobar",
      :database => "todo"
    )


=begin

ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "localhost",
      :username => "rails_user",
      :password => "user",
      :database => "rails_user"
    )
=end
