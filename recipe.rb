# recipe.rb
class Recipe
  attr_reader :title, :ingredients, :method, :difficulty, :time, :marked

  def initialize(attributes = {})
    @title = attributes[:title]
    @ingredients = attributes[:ingredients]
    @method = attributes[:method]
    @difficulty = attributes[:difficulty]
    @time = attributes[:time]
    @marked = attributes[:marked]
  end

  def mark_done
    @marked = true
  end

  def marked?
    @marked
  end

  # --> View

  def to_s
    "#{@title} (#{@time} mins) -- #{@difficulty}"
  end

  # --> Writing

  def self.headers
    %i[title ingredients method difficulty time marked]
  end

  def to_array
    [@title, @ingredients, @method, @difficulty, @time, @marked]
  end
end
