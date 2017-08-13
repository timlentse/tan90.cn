class ClockHotel < ActiveRecord::Base
  def self.search(args = {})
    @page_id = (args[:page] || 1).to_i
    args.delete(:page)
    @hotels = self.where(args).offset((@page_id-1)*Settings.kaminari_perpage).limit(Settings.kaminari_perpage)
  end

  def booking_url
    "http://m.elong.com/clockhotel/#{elong_id}/"
  end
end
