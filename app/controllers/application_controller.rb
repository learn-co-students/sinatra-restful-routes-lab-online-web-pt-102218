class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get "/recipes" do
    @recipes = Recipe.all
    erb :"/recipes/all"
  end

  get "/recipes/new" do
    erb :"/recipes/new"
  end

  post "/recipes" do
    @recipe = Recipe.create(name: params[:name],ingredients: params[:ingredients], cook_time: params[:cook_time])
    if @recipe
      @recipe.save
      redirect "/recipes/#{@recipe.id}"
    end
  end

  get "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    erb :"recipes/show"
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by(id: params[:id])
    erb :"recipes/edit"
  end

  patch "/recipes/:id/edit" do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "recipes/#{@recipe.id}"
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    redirect "/recipes"
  end

end
