# cookbook.rb
class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    read_csv
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    write_csv
  end

  def delete(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  def mark_done(recipe_index)
    @recipes.each_with_index { |recipe, i| recipe.mark_done if recipe_index == i }
    write_csv
  end

  private

  def read_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      @recipes << build_element(row)
    end
  end

  def write_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << @recipes.first.class.headers
      @recipes.each { |recipe| csv << recipe.to_array }
    end
  end

  def build_element(row)
    row[:time] = row[:time].to_i
    row[:marked] = row[:marked] == 'true'
    Recipe.new(row)
  end
end
