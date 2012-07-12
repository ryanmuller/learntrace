require 'xmlsimple'
require 'open-uri'
$:.push(File.dirname($0))
require "thumb_find.rb"

File.open('/Users/ramuller/src/trace/thumbin.txt').each_line do |line|
  # (note... key [row, col] values are indexed from 1)
  puts find_thumb(line.strip)
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

