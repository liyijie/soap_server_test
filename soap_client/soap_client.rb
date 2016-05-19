require 'savon'
require "nokogiri"

client = Savon::Client.new(wsdl: "http://localhost:3000/rooms/wsdl")
# client = Savon::Client.new(wsdl: "http://admin.smart-health.cn/webservice/webservice1.asmx?WSDL")

puts "client.operations is :#{client.operations}" # => [:integer_to_string, :concat, :add_circle]

builder = Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
  xml.businessdata {
    xml.functioncode 2000
  }
end
puts "xml is:#{builder.to_xml}"

result = client.call(:fun_main, message: {cmd: builder.to_xml.to_s} )
puts result
# result = client.call(:concat, message: { :a => "123", :b => "abc" })

# actual wash_out
# result.to_hash # => {:concat_reponse => {:value=>"123abc"}}

# wash_out below 0.3.0 (and this is malformed response so please update)
# result.to_hash # => {:value=>"123abc"}