require 'pathname'

require 'lesson2/config'
require 'lesson2/application'
require 'lesson2/handle'
require 'lesson2/data_valid'
require 'lesson2/todo'
require 'lesson2/admin'
module Lesson2
  # Load configuration
  #
  def self.config
    @config ||= Config.new(root_path.join('config', 'application.yml'))
  end
  
  # Lesson1.root_path.join('..')
  #
  def self.root_path
    @root_path ||= Pathname.new( File.dirname(File.expand_path('../', __FILE__)) )
  end

ActiveRecord::Base.establish_connection(
      :adapter  => "mysql2",
      :host     => "localhost",
      :username => "todo_user",
      :password => "foobar",
      :database => "todo"
    )

  class Todo < ActiveRecord::Base
  end

  class User < ActiveRecord::Base
  end

end