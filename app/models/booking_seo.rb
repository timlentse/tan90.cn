class BookingSeo

  def initialize(city, page_type, hotel=nil)
    @city, @page_type, @hotel = city, page_type, hotel
  end

  def get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@city[0].country_name}酒店"}]
    when 'city'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@city.country_name}酒店", :url=>"/booking/#{@city.country_code}/"},{:text=>"#{@city.name_cn}酒店"}]
    when 'detail'
      []
    end
  end

  def get_tdk
    case @page_type
    when 'country'
      cc_cn = @city[0].country_name
      desc = @city.pluck(:name_cn).join(",")
      {
        :title=>"#{cc_cn}酒店预订_#{cc_cn}酒店推荐-#{cc_cn}酒店",
        :keywords=>"#{cc_cn}酒店,#{cc_cn}酒店预订",
        :description=>"#{cc_cn}酒店预订，为你推荐#{desc}等热门#{cc_cn}城市酒店预订服务。",
        :h1=>"#{cc_cn}酒店"
      }
    when 'city'
      desc = @hotel.pluck(:name_cn).join(",")
      city_cn = @city.name_cn
      {
        :title=>"#{city_cn}酒店_#{city_cn}酒店预订-#{city_cn}酒店",
        :keywords=>"#{city_cn}酒店,#{city_cn}住宿",
        :description=>"预订#{city_cn}酒店，为你推荐#{desc}。",
        :h1=>"#{city_cn}酒店"
      }
    when 'detail'
      {}
    end
  end

  def get_footer_links
  end

end
