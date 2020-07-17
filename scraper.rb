require 'open-uri'
require 'nokogiri'
require 'csv'

chien = 'golden-retriever'
url = "https://www.woopets.fr/chien/race/#{chien}/"

def scrape(url)

  prix = []
  all= []

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.titleRaceh1').each do |element|
    all.push(element.text.strip)
    # puts element.attribute('href').value
    prix << {
      nom: all[0],
  }
  end

  html_doc.search('.priceBloc .mini span').each do |element|
    prix.push(element.text.strip)
  end

    print prix
    # puts element.attribute('href').value
    all << {
      mini_prix: prix[0],
      mini_budget: prix[1]
  }

  html_doc.search('.maxi span').each do |element|
    max = element.text.strip
    # puts element.attribute('href').value
    all << {
      maxi: max,
  }
  end

   CSV.open('prix.csv','a') do |csv|
     prix.each do |x|
       csv << [
         x[:nom],
         x[:mini_prix],
         x[:mini_budget],
       ]
     end
   end
end
scrape(url)