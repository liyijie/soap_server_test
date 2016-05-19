class RoomsController < ApplicationController
  respond_to :xml

  soap_service namespace: 'urn:WashOut'

  # soap_action "AddRecord",
  #             :args   => { :circle => { :center => { :@x => :integer,
  #                                                    :@y => :integer },
  #                                       :@radius => :double } },
  #             :return => nil, # [] for wash_out below 0.3.0
  #             :to     => :add_circle
  soap_action "funMain",
                :args   => { :cmd => :string },
                :return => { :funMainResult => :string },
                :to => :fun_main
  def fun_main
    puts "params is: #{params.inspect}"
    cmd = params[:cmd]
    xml_doc = Nokogiri::XML.parse(cmd)
    puts xml_doc.inspect

    builder = Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
      xml.businessdata {
        xml.errCode 0
        xml.errMsg "网络畅通"
      }
    end

    render :soap => {funMainResult: params[:cmd].to_s}
  end


  soap_action "concat",
              :args   => { :a => :string, :b => :string },
              :return => :string
  def concat
    puts "params is: #{params.inspect}"
    render :soap => (params[:a] + params[:b])
  end

  def test
    puts "params is: #{params.inspect}"
  end
end

