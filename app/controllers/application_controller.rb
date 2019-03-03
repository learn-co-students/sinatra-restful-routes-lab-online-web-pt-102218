class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    erb :index
  end

  get '/recipes/new' do
    erb :create
  end
  
  post '/recipes' do
    recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    if recipe.save
      redirect "/recipes/#{recipe.id}"
    else
      redirect '/error'
    end
  end
  
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end
  
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
  
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name, @recipe.ingredients, @recipe.cook_time = params[:name], params[:ingredients], params[:cook_time]
    binding.pry
    redirect to "/recipes/#{params[:id]}"
  end
  
  delete '/recipes/:id' do
    Recipe.find(params[:id]).delete
    redirect '/'
  end
  
  get '/error' do
    "Error"
  end

end
