class Seo

  COUNTRY={'taiwan'=>'台湾', 'japan'=>'日本', 'thailand'=>'泰国', 'korea'=>'韩国'}

  def initialize(page_type, hotels)
    @page_type = page_type
    unless page_type=='index'
      @hotel = hotels[0]
      @country = COUNTRY[@hotel.country]
      @country_en = @hotel.country
      @city_name = @hotel.city
      if page_type=='detail'
        @hotel_name_join = @hotel.name
      else
        @hotel_name_join = hotels.map(&:name).join('，')
      end
    end
  end

  def tdk
    {
      :title=>get_title,
      :keywords=>get_keywords,
      :description=>get_description,
      :h1=>get_h1
    }
  end

  def get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿"}]
    when 'city'
      [{:text=>"#{@country}民宿", :url=>"/#{@hotel.country}/"},{:text=>"#{@city_name}民宿"}]
    when 'detail'
      [{:text=>"#{@country}民宿", :url=>"/#{@hotel.country}/"},{:text=>"#{@city_name}民宿", :url=>"/#{@hotel.country}/#{@hotel.city_en}/"}, {:text=>@hotel.name}]
    end
  end

  def get_sitemap_links
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

  def get_h1
    "#{@city_name}民宿"
  end

  def get_title
    "#{@city_name}民宿_#{@city_name}酒店预订"
  end

  def get_keywords
    "#{@country}, #{@city_name},民宿,预订"
  end

  def get_description
    "#{@city_name}酒店，为你推荐#{@hotel_name_join}。"
  end

end
