    class CreateTodo < ActiveRecord::Migration do

      def self.up

      create_table :users do |t|
            t.integer  :userid
            t.string :fname
            t.string :sname
            t.date :date
            t.string :email
            t.passwd :passwd
       end

       add_index :users, :userid, :unique => true

      end

    end
