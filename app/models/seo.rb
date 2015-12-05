class Seo

  COUNTRY={'taiwan'=>'台湾', 'japan'=>'日本', 'thailand'=>'泰国', 'korea'=>'韩国'}

  def initialize(page_type, hotels)
    @page_type = page_type
    unless @page_type=='index'
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
  end

  def get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿"}]
    when 'city'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/#{@hotel.country}/"},{:text=>"#{@city_name}民宿"}]
    when 'detail'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/#{@hotel.country}/"},{:text=>"#{@city_name}民宿", :url=>"/#{@hotel.country}/#{@hotel.city_en}/"}, {:text=>@hotel.name}]
    end
  end

  def tdk
    case @page_type
    when 'index'
      {
        :title=>'台湾，日本，泰国，韩国民宿，客栈预订',
        :keywords=>'民宿,客栈',
        :description=>'为你推荐台湾，日本，泰国，韩国民宿客栈'
      }
    when 'detail'
      {
        :title=>"#{@hotel.name}_#{@hotel.name}预订",
        :keywords=>"#{@hotel.name},#{@city_name},民宿",
        :description=>"#{@city_name}民宿，为你推荐#{@hotel_name_join}。",
        :h1=>@hotel.name
      }
    when 'city'
      {
        :title=>"#{@city_name}民宿_#{@city_name}酒店预订",
        :keywords=>"#{@city_name},民宿",
        :description=>"#{@city_name}酒店，为你推荐#{@hotel_name_join}。",
        :h1=>"#{@city_name}民宿"
      }
    when 'country'
      {
        :title=>"#{@country}民宿,#{@country}酒店预订",
        :keywords=>"#{@country},民宿,价格",
        :description=>"#{@country}民宿,为你推荐#{@hotel_name_join}。",
        :h1=>"#{@country}民宿"
      }
    end
  end

  def get_footer_links
    @links = {}
    if @country_en
      @links[@country_en] = City.where(:country=>@country_en).map do |city|
        {'uri'=>"/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
      end
    else
      ['taiwan', 'japan', 'thailand', 'korea'].each do |country|
        @links[country] = City.where(:country=>country).map do |city|
          {'uri'=>"/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
        end
      end
    end
    @links
  end

end
