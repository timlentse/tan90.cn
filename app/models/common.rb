require 'booking_hot_destination'
class Common
  def self.tdk
    {
      :title=>'酒店预订，民宿推荐，住宿攻略-tan90.cn',
      :keywords=>'酒店,民宿,住宿',
      :description=>'为你推荐全球热门旅游城市的酒店，民宿，旅游住宿攻略',
      :h1=>"tan90.cn"
    }
  end

  def self.get_hot_destination
    mapper = ['热门区域','热门城市','热门地标']
    slinks=[]
    BookingHotDestination.where(:cate=>1).find_each do |ds|
      slinks[0].nil? ? slinks[0] = {:title=>'热门城市',:links=>[{:text=>ds.name_cn,:link=>"/booking/#{ds.cc}/#{ds.name_en}/",:addition=>ds.number_of_hotel}]} : slinks[0][:links].push({:text=>ds.name_cn,:link=>"/booking/#{ds.cc}/#{ds.name_en}/",:addition=>ds.number_of_hotel})
    end
    slinks
  end
end
