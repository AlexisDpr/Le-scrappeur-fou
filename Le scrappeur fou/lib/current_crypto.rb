require 'nokogiri'
require 'open-uri'

def crypto_scraper
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  crypto_values = page.xpath('//tr[@class="cmc-table-row"]')
 
  crypto_data = {}

  crypto_values.each do |crypto_value|
    crypto_name = crypto_value.xpath('td[2]/div/a[2]').text
    crypto_price = crypto_value.xpath('td[5]/div/a/span').text


    crypto_data[crypto_name] = crypto_price
  end
 
  return crypto_data
end

def display_crypto_data_as_list(crypto_data)
  crypto_data.each_with_index do |(crypto_name, crypto_price), index|
    puts "#{index + 1}. #{crypto_name}: #{crypto_price}"
  end
end


crypto_data = crypto_scraper()


display_crypto_data_as_list(crypto_data)