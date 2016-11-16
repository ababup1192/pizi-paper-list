require 'open-uri'
require 'nokogiri'

uri = 'https://www.jstage.jst.go.jp/result/-char/ja/?item1=4&word1=' + 
  '%E6%9F%B3%E7%94%BA%E6%94%BF%E4%B9%8B%E5%8A%A9&searchlocale=ja&start' + 
  '=0&count=50&order=1&requestLocale=ja'

doc = Nokogiri::HTML(open(uri))

paper_title = doc.css('.detailBox_meta>a').children.map{ |child| child.text }
paper_title.delete_at(13)
journal_info = doc.css('.detailBox_meta>.journal-info>li').children.map{ |child|
 child.children.map{|child| child.text.strip.gsub("\t", "").gsub("\r\n", "").
                    gsub(" ", "") } }.select{|child| 
   child.empty? == false }.each_slice(3).map{|child| 
     child.flatten.select{|child| child.empty? == false }.join(",")} 

puts paper_title.zip(journal_info).map{|pj| "#{pj[0]}, #{pj[1]}" }.join("\n")
