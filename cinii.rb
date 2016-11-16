require 'open-uri'
require 'nokogiri'

uri = URI.escape('http://ci.nii.ac.jp/search?q=柳町政之助' +
                 '&range=0&count=100&sortorder=1&type=0')
doc = Nokogiri::HTML(open(uri))
paper_title = doc.css('.item_mainTitle').children.map { |child| 
  child.text.strip }.select { |child| child.empty? == false
}

journal_title = doc.css('.journal_title').children.map{ |child|
  child.text.strip }

puts paper_title.zip(journal_title).map{|pj| "#{pj[0]}, #{pj[1]}" }.join("\n")
