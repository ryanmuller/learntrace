# note: password 'test' was too short; changed it to adminpass
superuser = User.create({ :email => 'support@learnstream.org', :password => 'adminpass', :password_confirmation => 'adminpass' })


require 'xmlsimple'
require 'open-uri'

# Gets data from server, initializes parsed hash
url = "https://spreadsheets.google.com/feeds/cells/0Aip67rN0jLtfdHVuWjZsd1poaDlsVFRxWHNwN1RHbnc/1/public/values"

open(url) do |d| 
  xml = XmlSimple.xml_in(d.read)
  data = Hash.new{ |hash, key| hash[key] = {} }

  # Parses the xml hash into a data hash.
  # for example, the contents of cell [3,5] ([row, col]) can be accessed as "data[3][5]"
  xml['entry'].each {|x| data[x['cell'][0]['row'].to_i].merge!({ x['cell'][0]['col'].to_i =>  x['cell'][0]['content'] } ) }

  # (note... key [row, col] values are indexed from 1)
  data.each do |key, value|
    item = Item.create!({ :name => value[1], :url => value[3] })

    if value[4]
      tags = value[4].split(', ')
      tags.each do |tag_name| 
        unless tag = Tag.find_by_name(tag_name)
          tag = Tag.create!({ :name => tag_name })
        end
        item.tags.push_with_attributes(tag, :user => superuser)
      end
    end
  end
end

=begin
Item.create([{ :name => "Khan Academy Algebra", 
               :description => "Conceptual videos and worked examples from basic algebra through algebra 2. Includes videos from the former algebra worked examples playlists.",
               :url => "http://www.khanacademy.org/math/algebra" },
             { :name => "Khan Academy Arithmetic and Pre-Algebra",
               :description => "The first math topic. Start here if you want to learn the basics (or just want to make sure you know these topics). After this, you should be ready for algebra. This topic includes videos from the former developmental math playlists.",
               :url => "http://www.khanacademy.org/math/arithmetic" },
             { :name => "Khan Academy Geometry",
               :description => "Videos on geometry. After Basic Geometry list, videos assume you know introductory algebra concepts. After these videos, you'll be ready for Trigonometry.",
               :url => "http://www.khanacademy.org/math/geometry" }])
=end

