require 'sinatra'
require 'sequel'

DB = Sequel.sqlite('db/posts.db')

class Post < Sequel::Model
end

get "/" do
  @posts = Post.order("id DESC")
  erb :index
end

get "/posts/create" do
	@post = Post.new
	erb :create
end

post "/posts" do
  @post = Post.new(params)
  if @post.save
    redirect "posts/#{@post.id}"
  else
    redirect "posts/create"
  end
end


get "/posts/:id" do
  @post = Post[params[:id]]
  erb :view
end

get "/posts/:id/edit" do
 @post = Post[params[:id]]
 @title = "Edit Form"
 erb :edit
end

put "/posts/:id" do
  @post = Post[params[:id]]
   if @post.update(params[:post])
    redirect "/posts/#{@post.id}"
  else
    erb :"posts/edit"
  end
end

delete "/posts/:id" do
  @post = Post[params[:id]].destroy
  redirect "/"
end
helpers do

  def post_show_page?
    request.path_info =~ /\/posts\/\d+$/
  end
  
  def delete_post_button(post_id)
    erb :_delete_post_button, locals: { post_id: post_id}
  end

end

