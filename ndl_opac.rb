require 'open-uri'
require 'nokogiri'

uri = 'https://ndlopac.ndl.go.jp/F/KKECTJ4JVRTM6V2URXUG' + 
  'B2VLRFTVB9PISKR5KF35RCINUYTTG1-11822?func=short-jump&jump=1'
doc = Nokogiri::HTML(open(uri))

paper_title = doc.css('.t-td').children.map { |child| 
  child.text.strip }.to_a.each_slice(27){|child| 
    puts child.join(",")
  }
# .to_a[0..26] 

#journal_title = doc.css('.journal_title').children.map{ |child|
#  child.text.strip }

# puts paper_title.zip(journal_title).map{|pj| "#{pj[0]}, #{pj[1]}" }.join("\n")
