# app.rb

# Gems
require 'better_errors'
require 'csv'
require 'nokogiri'
require 'open-uri'
require 'pry-byebug'
require 'sinatra'
require 'sinatra/reloader' if development?
set :bind, '0.0.0.0'

# Ruby files
require_relative 'cookbook'
require_relative 'recipe'
require_relative 'scrape'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

# Load constants
COOKBOOK = Cookbook.new('./recipes.csv')
SCRAPE = Scrape.new

# 1. List all recipes - @controller.list
get '/' do
  @recipes = COOKBOOK.all
  erb :index
end

# 2. Add a recipe - @controller.add
get '/new' do
  erb :new
end

post '/recipes' do
  COOKBOOK.add(Recipe.new(params))
  redirect '/'
end

# 3. Delete a recipe - @controller.delete
get '/destroy/:index' do
  COOKBOOK.delete(params[:index].to_i)
  redirect '/'
end

# 4. Mark a recipe as done - @controller.mark
get '/mark/:index' do
  COOKBOOK.mark_done(params[:index].to_i)
  redirect '/'
end

# 5. Import recipes from LetsCookFrench - @controller.import
get '/import' do
  erb :import
end

post '/top_five' do
  @top_five = SCRAPE.top_five(params[:keyword])
  erb :top_five
end

get '/choice' do
  COOKBOOK.add(Recipe.new(SCRAPE.chosen(params[:title], params[:path])))
  redirect '/'
end
