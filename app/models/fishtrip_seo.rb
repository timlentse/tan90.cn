class FishtripSeo

  COUNTRY={'taiwan'=>'台湾', 'japan'=>'日本', 'thailand'=>'泰国', 'korea'=>'韩国'}

  def initialize(page_type, addition_object)
    @page_type = page_type
    unless @page_type=='index'
      if @page_type=='detail'
        @obj = addition_object
        @pre_desc = @obj.name
      elsif @page_type=='article'
        @obj = addition_object
      else
        @pre_desc = addition_object.map(&:name).join('，')
        @obj = addition_object[0]
      end
      @country = COUNTRY[@obj.country]
      @country_en = @obj.country
      @city_name = @obj.city
    end
  end

  def get_breadcrumb
    case @page_type 
    when 'country'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿"}]
    when 'query'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/#{@country_en}/"},{:text=>"#{@city_name}民宿搜索页"}]
    when 'city'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/#{@country_en}/"},{:text=>"#{@city_name}民宿"}]
    when 'detail'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/#{@country_en}/"},{:text=>"#{@country}#{@city_name}民宿", :url=>"/fishtrip/#{@country_en}/#{@obj.city_en}/"}, {:text=>@obj.name}]
    when 'article'
      [{:text=>'首页', :url=>'/'}, {:text=>"#{@country}民宿", :url=>"/#{@country_en}/"},{:text=>"#{@country}#{@city_name}民宿", :url=>"/fishtrip/#{@country_en}/#{@obj.city_en}/"}, {:text=>@obj.title}]
    end
  end

  def tdk
    case @page_type
    when 'index'
      {
        :title=>'台湾民宿，日本民宿，泰国民宿，韩国民宿，客栈预订-住宿指南',
        :keywords=>'民宿,客栈,住宿',
        :description=>'为你推荐涵盖台湾，日本，泰国，韩国等热门旅游城市的民宿，客栈，旅游住宿攻略'
      }
    when 'detail'
      {
        :title=>"#{@obj.name}_#{@city_name}民宿价格-#{@city_name}民宿",
        :keywords=>"#{@obj.name},#{@city_name},民宿,住宿",
        :description=>"#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
        :h1=>@obj.name
      }
    when 'city'
      {
        :title=>"#{@country}#{@city_name}民宿_#{@city_name}民宿推荐_#{@city_name}民宿点评-#{@city_name}民宿",
        :keywords=>"#{@country}民宿,#{@city_name}民宿,民宿",
        :description=>"#{@country}#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
        :h1=>"#{@country}#{@city_name}民宿"
      }
    when 'query'
      {
        :title=>"#{@city_name}民宿搜索结果",
        :keywords=>"#{@city_name},民宿",
        :description=>"#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
        :h1=>"#{@city_name}民宿"
      }
    when 'country'
      {
        :title=>"#{@country}民宿_怎么订#{@country}民宿-#{@country}民宿",
        :keywords=>"#{@country},民宿,价格,住宿",
        :description=>"#{@country}民宿, #{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
        :h1=>"#{@country}民宿"
      }
    when 'article'
      {
        :title=>"#{@obj.title}_#{@country}#{@obj.type_name}",
        :keywords=>"#{@country},#{@obj.title},#{@obj.type_name}",
        :description=>"",
        :h1=>@obj.title
      }
    end
  end

  def get_footer_links
    @links = {}
    if @country_en
      @links[@country_en] = FishtripCity.where(:country=>@country_en).map do |city|
        {'uri'=>"/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
      end
    else
      ['taiwan', 'japan', 'thailand', 'korea'].each do |country|
        @links[country] = FishtripCity.where(:country=>country).map do |city|
          {'uri'=>"/#{city.country}/#{city.name_en}/", 'text'=>"#{city.name}民宿"}
        end
      end
    end
    @links
  end

end
