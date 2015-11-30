class Seo

  COUNTRY={'taiwan'=>'台湾', 'japan'=>'日本', 'thailand'=>'泰国', 'korea'=>'韩国'}

  def self.init_var(params, page_type, hotels)
    @page_type, @params = page_type, params
    @hotel_name_join = hotels.map(&:name).join('，')
    @hotel = hotels[0]
    @country = COUNTRY[@params[:country]]
    @city_name = @hotel.city
  end

  def self.tdk
    {
      :title=>get_title,
      :keywords=>get_keywords,
      :description=>get_description,
      :h1=>get_h1
    }
  end

  def self.get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/taiwan/'}, {:text=>"#{@country}民宿"}]
    when 'city'
      [{:text=>@country, :url=>"/#{@hotel.country}/"},{:text=>"#{@city_name}民宿"}]
    end
  end

  def self.get_sitemap_links

  end

  def self.get_footer_links
    City.where(:country=>@params[:country]).map do |city|
      {'uri'=>"/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
    end
  end

  def self.get_h1
    "#{@city_name}民宿"
  end

  def self.get_title
    "#{@city_name}民宿_#{@city_name}酒店预订"
  end

  def self.get_keywords
    "#{@country}, #{@city_name},民宿,预订"
  end

  def self.get_description
    "#{@city_name}酒店，为你推荐#{@hotel_name_join}。"
  end

end
