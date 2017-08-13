class FishtripHotel < ActiveRecord::Base
  has_many :comments, primary_key: :fishtrip_hotel_id, foreign_key: :fishtrip_hotel_id, class_name: 'FishtripComment'
  has_many :rooms, foreign_key: :hotel_id, class_name: 'FishtripRoom'

  HOT = {"taiwan"=>{:ids=>["9566344830", "9392469101", "9837406394", "9168466069", "9449314665", "9258344719", "9541514029", "9570405924", "9334696707"]}, "japan"=>{:ids=>["9929823957", "9254173377", "10060857817", "9601835114", "10681287023", "9467832771", "9567009714", "9235329397", "10463630361", "10649934587", "9937744842", "10168514799"]}, "thailand"=>{:ids=>["10060979344", "9742959157", "10352499033", "9271830775", "10414696625", "9638331808", "9520636775", "9416245869", "10089495831", "10474191350", "8631462623", "10415365621"]}, "korea"=>{:ids=>["8987465052", "9730496979", "9769743091", "10412208267", "9534249319", "9357648315", "10269760827", "9183312413", "8991818291", "10705455599", "10207775026", "9598544063", "8698325951", "10419362361", "10641685143"]}}

  # Filter function
  def self.search(args={})
    @page_id = args[:page]
    conditions = args.reject{|k,v| k.to_s=='page'}
    if @page_id and @page_id.to_i>1
      @hotels = self.where(conditions).offset((@page_id.to_i-1)*21).order(:page_id).limit(21)
    else
      @hotels = self.where(conditions).order(:page_id).limit(21)
    end
  end

  def self.search_hot(country)
    ids = HOT[country][:ids]
    self.where(fishtrip_hotel_id: ids).includes(:comments, :rooms)
  end

  def self.select_recommend_hotels(city_id, hotel_id)
    self.where(city_id: city_id).sample(12)
  end

  def country_name
    FishtripSeo::COUNTRY[country]
  end

  def image_url
    "http://7xotew.com1.z0.glb.clouddn.com/#{fishtrip_hotel_id}-large.jpg"
  end

  def unique_link
    "/fishtrip/#{fishtrip_hotel_id}/"
  end
end
