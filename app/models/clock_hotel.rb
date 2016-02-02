class ClockHotel < ActiveRecord::Base

  def self.search(args={})
    @page_id = args[:page]
    conditions = args.reject{|k,v| k.to_s=='page'}
    if @page_id and @page_id.to_i>1
      @hotels = self.where(conditions).offset((@page_id.to_i-1)*20).limit(20)
    else
      @hotels = self.where(conditions).limit(20)
    end
  end

end
