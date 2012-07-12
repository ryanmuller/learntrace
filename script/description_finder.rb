require 'nokogiri'
require 'open-uri'
require 'csv'

def get_mit(url)
	doc = Nokogiri::HTML(open(url))
	string = doc.xpath('//*[@id="parent-fieldname-description"]/p').text.strip 
end

def get_ted(url)
	doc = Nokogiri::HTML(open(url))
	string = doc.xpath('//*[@class="talk-intro"]/p[1]/text()').text.strip + "\n\n" + doc.xpath('//*[@class="talk-intro"]/p[2]/text()').text.strip
end

def get_khan(url)
	doc = Nokogiri::HTML(open(url))
	string = doc.xpath('//*[@class="topic-desc"]').text.strip 
end

def get_udacity(url)
	doc = Nokogiri::HTML(open(url))
	string = doc.xpath('//*[@class="course-overview-description-body"]/p').text.strip 
end

def get_treehouse(url)
	doc = Nokogiri::HTML(open(url))
	string = doc.xpath('//*[@class="module"]/p').text.strip
end

def get(url)
	doc = Nokogiri::HTML(open(url))
end

def go
	CSV.open('out-treehouse.csv', 'wb') do |csv|
		CSV.foreach('sheet.csv') do |row|
			p row[1]
			if row[1] == "treehouse" 
				p row[2]
				csv << [row[2], get_treehouse(row[2])]
			end
		end
	end

end
