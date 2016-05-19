class RoomsController < ApplicationController
  soap_service namespace: 'urn:WashOut'
  
  soap_action "AddCircle",
              :args   => { :circle => { :center => { :@x => :integer,
                                                     :@y => :integer },
                                        :@radius => :double } },
              :return => nil, # [] for wash_out below 0.3.0
              :to     => :add_circle
  def add_circle
    circle = params[:circle]
    Circle.new(circle[:center][:x], circle[:center][:y], circle[:radius])

    render :soap => nil
  end
end
