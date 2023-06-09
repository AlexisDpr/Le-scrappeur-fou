require 'nokogiri'
require 'open-uri'

# méthode pour scraper une page
def crypto_scraper
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  crypto_values = page.xpath('//tr[@class="cmc-table-row"]')
 
  # créer un hash vide pour stocker les données de chaque crypto-monnaie
  crypto_data = {}

  # Itérer sur chaque ligne du tableau pour extraire les données
  crypto_values.each do |crypto_value|
    crypto_name = crypto_value.xpath('td[2]/div/a[2]').text # extraire le nom de la crypto
    crypto_price = crypto_value.xpath('td[5]/div/a/span').text # extraire la valeur de la crypto

    # ajouter les données de la crypto-monnaie au hash crypto_data
    crypto_data[crypto_name] = crypto_price
  end
 
  return crypto_data
end

# méthode pour iterer chaque ligne du hash afin de l'afficher sous forme de liste numérotée
def display_crypto_data_as_list(crypto_data)
  crypto_data.each_with_index do |(crypto_name, crypto_price), index|
    puts "#{index + 1}. #{crypto_name}: #{crypto_price}"
  end
end

# Appeler la fonction crypto_scraper pour récupérer le hash de toutes les données de crypto-monnaies
crypto_data = crypto_scraper()

# Afficher les données de crypto-monnaies sous forme de liste
display_crypto_data_as_list(crypto_data)