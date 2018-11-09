require 'open-uri'
require 'nokogiri'

file = 'lib/strawberry_meringues.html'
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# attributes = {}

frag = doc.search('.m_bloc_cadre')



# attribute[:ingredients] = .m_avec_substitution
frag.search('.m_content_recette_ingredients').text.strip.gsub(/\s+/, ' ')
# attribute[:method] = f
frag.search('.m_content_recette_todo').text.strip.gsub(/\s+/, ' ')

# attribute[:diff] =
p frag.search('.m_content_recette_breadcrumb').text.strip.gsub(/\s+/, ' ').split(/-(\s[\w\s]+)/)[1].strip

