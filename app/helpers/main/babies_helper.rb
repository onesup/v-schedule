#encoding:utf-8
module Main::BabiesHelper
  
  def least_display(baby,vaccination)
    
    timing = l((@baby.born_at + vaccination.timing).to_date, :format => :default )
    time_ago = time_ago_in_words(@baby.born_at + vaccination.timing)
      
    unless vaccination.least.nil?
      least = l((@baby.born_at + vaccination.least).to_date, :format => :default)  
      "접종기간은 #{timing} ~ #{least}입니다. (#{time_ago})남았습니다.)"
    else 
      "접종일은 #{timing}입니다. (#{time_ago}남았습니다.)"
    end  
      
  end
  
end
