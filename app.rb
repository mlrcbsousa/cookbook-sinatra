# app.rb

# Gems
require 'better_errors'
require 'csv'
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

COOKBOOK = Cookbook.new('./recipes.csv')

# 1. List all recipes - @controller.list
get '/' do
  @recipes = COOKBOOK.all

  erb :index
end

# 2. Add a recipe - @controller.add
# 3. Delete a recipe - @controller.delete
# 4. Mark a recipe as done - @controller.mark

  # def ask_for_string(string)
  #   puts ""
  #   puts "What is the recipe #{string}?"
  #   print '> '
  #   gets.chomp
  # end

  # def ask_index
  #   puts ""
  #   puts 'What is the recipe number?'
  #   print '> '
  #   gets.chomp.to_i - 1
  # end

get '/about' do
  erb :about
end

post '/' do
  p ".. create something .."
end

get '/team/:username' do
  # puts params[:username]
  "The username is #{params[:username]}"
end

# # 5. Import recipes from LetsCookFrench - @controller.import
#   # --------------> Importing

#   def ask_for_keyword
#     puts 'What ingredient would you like a recipe for?'
#     print '> '
#     gets.chomp
#   end

#   def list_five(top_five, keyword)
#     puts ""
#     puts "Looking for #{keyword} on LetsCookFrench..."
#     puts ""
#     top_five.each_with_index { |title, i| puts "#{i + 1}. #{title}" }
#     puts ""
#   end

#   def ask_index_import
#     puts "Which recipe would you like to import? (enter index)"
#     print '> '
#     gets.chomp.to_i - 1
#   end

#   def importing(title)
#     puts ""
#     puts "Importing \"#{title}\"..."
#     puts ""
#   end
