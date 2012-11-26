# -*- encoding: utf-8 -*-

module Lesson2

	class Todos
		attr_reader :todo_list, :todo_save

		def list
			@todo_list = Todo.select("id, head").all
			return @todo_list
		end

		def save(env)
			@id = env['id']
			@body = env['todo_body']
			@head = "def"
			@time_create = "def"
			@time_end = "def"
			@status = 0
			@todo_save = @id.to_s + " " + @body.to_s + " " + @head.to_s + " " + @time_create.to_s + " " + @time_end.to_s + " " + @status.to_s
			return @todo_save
		end
	end

end