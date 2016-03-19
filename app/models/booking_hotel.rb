class BookingHotel < ActiveRecord::Base

  has_many :booking_reviews, :primary_key=>'id', :foreign_key=>'hotel_id'

  def self.search(args={})
    @page_id = args[:page]
    conditions = args.reject{|k,v| k.to_s=='page'}
    if @page_id and @page_id.to_i>1
      @hotels = self.where(conditions).offset((@page_id.to_i-1)*21).limit(21)
    else
      @hotels = self.where(conditions).limit(21)
    end
  end

  def self.find_hotels_by_ids(hotel_ids)
    self.where(:id=>hotel_ids)
  end

  def get_nearby_hotels
    hotel_ids=JSON.parse(self.nearby_hotels)
    self.class.select(:id,:name_cn,:address_cn,:minrate,:photo_url,:currencycode).where(id:hotel_ids).take(6)
  end

end
