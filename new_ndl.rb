require 'open-uri'
require 'nokogiri'

all_info = (1..6).map do |num|
  index_uri = URI.escape("http://iss.ndl.go.jp/books?ar=4e1f&any=柳町政之助&page=#{num}")
  index_doc = Nokogiri::HTML(open(index_uri))

  paper_links = index_doc.css('.item_group_wrapper>div>.item_result>div>h3').children.map do |child|
    child.attr('href')
  end.select do |link|
    link.nil? == false
  end

  paper_links.map do |link|
    doc = Nokogiri::HTML(open(link))

    table_row = doc.css('tr').children
    info_tmp = table_row.map do |child|
      child.text.strip
    end

    info_tmp.select { |child| child.empty? == false }
            .each_with_index.select do |child|
      child[1].odd?
    end.map do |child|
      child[0]
    end.join('$')
  end
end

puts all_info.join("\n")
