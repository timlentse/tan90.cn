class FishtripHotel < ActiveRecord::Base
  has_many :fishtrip_comments, :primary_key=>'fishtrip_hotel_id'
  HOT = {
    'taiwan'=> {:ids=>["9566344830", "9837406394", "9392469101", "9168466069", "9258344719", "9449314665", "9541514029", "8807730148", "9570405924", "8819789346", "8742736353", "9739806411"]},
    "japan"=>{:ids=>["9601835114", "9254173377", "9929823957", "10060857817", "9937744842", "10681287023", "9567009714", "10463630361", "9235329397", "10649934587", "10278534447"]},
    "thailand"=>{:ids=>["9271830775", "9742959157", "10060979344", "10414696625", "9520636775", "10089495831", "9416245869", "10474191350", "8631462623", "10352499033", "9113218463"]},
    "korea"=>{:ids=>["10207775026", "8987465052", "10412208267", "9769743091", "9730496979", "10298870553", "10154163442", "10638595855", "9694758024", "9569679857", "10210035593", "8985204869", "10265928885", "8929311705", "9041077148", "9580895445", "9132004647", "10165903318", "10536452768", "8602890434", "9029337272", "10692391979", "9703175876", "9162849675", "10368067860"]}}

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
    self.where(fishtrip_hotel_id: ids)
  end

  def self.select_recommend_hotels(city_id, hotel_id)
    self.where(:city_id=>city_id).sample(12)
  end

  end

