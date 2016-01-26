class BookingSeo

  def initialize(location, page_type)
    @location, @page_type = location, page_type
  end

  def get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@location[0].country_name}酒店"}]
    when 'city'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@location.country_name}酒店", :url=>"/booking/#{@location.country_code}/"},{:text=>"#{@location.name_cn}酒店"}]
    when 'landmark'
      [{:text=>'首页', :url=>'/'}, {:text=>"中国酒店", :url=>"/booking/#{@location.country_code}/"},{:text=>"#{@location.name_cn}附近酒店"}]
    when 'airport'
      [{:text=>'首页', :url=>'/'}, {:text=>"中国酒店", :url=>"/booking/#{@location.country_code}/"},{:text=>"#{@location.name_cn}附近酒店"}]
    when 'review'
      [{:text=>'Home', :url=>'/'},{:text=>@country.country_or_region,:url=>"/booking/#{@country.cc}/"},{:text=>@location.name,:url=>"/booking/#{@location.country_code}/#{@location.full_name}/"},{:text=>"#{@location.name} hotel reviews"}]
    when 'detail'
      []
    end
  end

  def get_tdk
    case @page_type
    when 'country'
      cc_cn = @location[0].country_name
      desc = @location.pluck(:name_cn).join(",")
      {
        :title=>"#{cc_cn}酒店预订_#{cc_cn}酒店推荐-#{cc_cn}酒店",
        :keywords=>"#{cc_cn}酒店,#{cc_cn}酒店预订",
        :description=>"#{cc_cn}酒店预订，为你推荐#{desc}等热门#{cc_cn}城市酒店预订服务。",
        :h1=>"#{cc_cn}酒店"
      }
    when 'city'
      city_cn = @location.name_cn
      {
        :title=>"#{city_cn}酒店_#{city_cn}酒店预订-#{city_cn}酒店",
        :keywords=>"#{city_cn}酒店,#{city_cn}住宿",
        :description=>"预订#{city_cn}酒店，为你提供#{city_cn}#{@location.number_of_hotels}多家酒店的预订服务，价格查询，酒店点评，住宿推荐。",
        :h1=>"#{city_cn}酒店"
      }
    when 'landmark'
      landmark = @location.name_cn
      {
        :title=>"#{landmark}附近酒店_#{landmark}酒店预订",
        :keywords=>"#{landmark}附近酒店,#{landmark}周边酒店,#{landmark}酒店",
        :description=>"预订#{landmark}附近酒店，即可享受超值优惠。为你提供#{landmark}附近酒店预订服务，价格查询，酒店点评信息。",
        :h1=>"#{landmark}附近酒店"
      }
    when 'airport'
      airport = @location.name_cn
      {
        :title=>"#{airport}附近酒店_#{airport}酒店预订",
        :keywords=>"#{airport}附近酒店,#{airport}周边酒店,#{airport}酒店",
        :description=>"预订#{airport}附近酒店，即可享受超值优惠。为你提供#{airport}附近酒店预订服务，价格查询，酒店点评信息。",
        :h1=>"#{airport}附近酒店"
      }
    when 'review'
      city_en = @location.name
      @country = Country.find_by(:cc=>@location.country_code)
      {
        :title=>"Hotel reviews in #{city_en}",
        :keywords=>"hotel reviews, hotels in #{city_en}, #{city_en} hotel reviews",
        :description=>"Browse hotel reviews for the best B&Bs and inns in #{city_en}, #{@country.country_or_region}. Find more than 51 million reviews and great prices on tan90.cn",
        :h1=>"Hotel reviews in #{city_en}"
      }

    when 'detail'
      {}
    end
  end

  def get_footer_links
  end

  def get_landmarks_with_city
    @landmarks = []
    return if @location.name.empty? or @location.country_code!='cn'
    landmarks = BookingLandmark.where(:city=>@location.name)
    landmarks.find_each do |landmark|
      @landmarks.push({:text=>"#{landmark.name_cn}附近酒店",:url=>"/booking/landmark/#{landmark.id}/"})
    end
    @landmarks
  end

end
