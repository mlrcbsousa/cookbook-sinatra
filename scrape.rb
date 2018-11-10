# scrape.rb
class Scrape
  def top_five(keyword)
    url = 'http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=' + keyword
    doc = Nokogiri::HTML(open(url).read, nil, 'utf-8')

    recipes = []
    doc.search('.m_titre_resultat a').map.each_with_index do |element, i|
      title = element.text.strip
      path = element.attribute('href').value
      recipes[i] = [title, path]
    end
    recipes.slice(0, 5)
  end

  def chosen(title, path)
    url = 'http://www.letscookfrench.com' + path
    frag = Nokogiri::HTML(open(url).read, nil, 'utf-8').search('.m_bloc_cadre')

    {
      title: title,
      ingredients: frag.search('.m_content_recette_ingredients').text.strip.gsub(/\s+/, ' '),
      method: frag.search('.m_content_recette_todo').text.strip.gsub(/\s+/, ' '),
      difficulty: frag.search('.m_content_recette_breadcrumb').text.strip.gsub(/\s+/, ' ').split(/-(\s[\w\s]+)/)[1].strip,
      time: frag.search('.preptime').text.strip.to_i + frag.search('.cooktime').text.to_i,
    }
  end
end
