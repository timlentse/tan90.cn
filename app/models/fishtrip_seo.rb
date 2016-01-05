class FishtripSeo

  COUNTRY={'taiwan'=>'台湾', 'japan'=>'日本', 'thailand'=>'泰国', 'korea'=>'韩国'}

  def initialize(page_type, hotels)
    @page_type = page_type
    if @page_type=='detail'
      @hotel = hotels
      @hotel_name_join = @hotel.name
    else
      @hotel = hotels[0]
      @hotel_name_join = hotels.map(&:name).join('，')
    end
    @country = COUNTRY[@hotel.country]
    @country_en = @hotel.country
    @city_name = @hotel.city
  end

  def get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿"}]
    when 'query'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/fishtrip/#{@hotel.country}/"},{:text=>"#{@city_name}民宿搜索页"}]
    when 'city'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/fishtrip/#{@hotel.country}/"},{:text=>"#{@city_name}民宿"}]
    when 'detail'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/fishtrip/#{@hotel.country}/"},{:text=>"#{@city_name}民宿", :url=>"/fishtrip/#{@hotel.country}/#{@hotel.city_en}/"}, {:text=>@hotel.name}]
    end
  end

  def tdk
    case @page_type
    when 'detail'
      {
        :title=>"#{@hotel.name}_怎么订#{@hotel.name}民宿-#{@city_name}民宿",
        :keywords=>"#{@hotel.name},#{@city_name},民宿,住宿",
        :description=>"#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@hotel_name_join}。",
        :h1=>@hotel.name
      }
    when 'city'
      {
        :title=>"#{@city_name}民宿_怎么订#{@city_name}民宿-#{@city_name}民宿",
        :keywords=>"#{@city_name},民宿,住宿",
        :description=>"#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@hotel_name_join}。",
        :h1=>"#{@city_name}民宿"
      }
    when 'query'
      {
        :title=>"#{@city_name}民宿搜索结果",
        :keywords=>"#{@city_name},民宿",
        :description=>"#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@hotel_name_join}。",
        :h1=>"#{@city_name}民宿"
      }
    when 'country'
      {
        :title=>"#{@country}民宿,怎么订#{@country}民宿-#{@country}民宿",
        :keywords=>"#{@country},民宿,价格,住宿",
        :description=>"#{@country}民宿, #{@city_name}自由行住宿，为你推荐#{@hotel_name_join}。",
        :h1=>"#{@country}民宿"
      }
    end
  end

  def get_footer_links
    @links = {}
    if @country_en
      @links[@country_en] = FishtripCity.where(:country=>@country_en).map do |city|
        {'uri'=>"/fishtrip/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
      end
    else
      ['taiwan', 'japan', 'thailand', 'korea'].each do |country|
        @links[country] = FishtripCity.where(:country=>country).map do |city|
          {'uri'=>"/fishtrip/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
        end
      end
    end
    @links
  end

end