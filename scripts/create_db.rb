require 'sequel'

DB = Sequel.sqlite('db/posts.db')

DB.create_table :posts do
	primary_key :id
	string   :title
	text     :body
	datetime :created_at
end
