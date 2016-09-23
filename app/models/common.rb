class Common
  def self.tdk
    {
      :title=>'酒店预订_民宿推荐_住宿攻略_九九九五网',
      :keywords=>'酒店,民宿,住宿',
      :description=>'为你推荐全球热门旅游城市的酒店，民宿，旅游住宿攻略',
      :h1=>"九九九五网"
    }
  end

  def self.get_hot_destinations
    mapper = ['热门区域','热门城市','热门地标']
    slinks=[]
    BookingHotDestination.where(:cate=>1,:is_show=>1).find_each do |ds|
      slinks[0].nil? ? slinks[0] = {:title=>'热门城市',:links=>[{:text=>ds.name_cn,:link=>"/booking/#{ds.cc}/#{ds.name_en}/",:addition=>ds.number_of_hotel}]} : slinks[0][:links].push({:text=>ds.name_cn,:link=>"/booking/#{ds.cc}/#{ds.name_en}/",:addition=>ds.number_of_hotel})
    end
    slinks
  end

  def self.get_fishtrip_links
    links = {}
    ['taiwan', 'japan', 'thailand', 'korea'].each do |country|
      links[country] = FishtripCity.where(:country=>country).map do |city|
        {'uri'=>"/fishtrip/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
      end
    end
    links
  end
end
