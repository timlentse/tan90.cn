class FishtripSeo
  COUNTRY = { 'taiwan'=>'台湾', 'japan'=>'日本', 'thailand'=>'泰国', 'korea'=>'韩国' }

  def initialize(page_type, addition_object)
    @page_type = page_type
    if @page_type == 'detail'
      @obj = addition_object
      @pre_desc = @obj.name
    elsif @page_type == 'article'
      @obj = addition_object
    else
      @pre_desc = addition_object.map(&:name).join('，')
      @obj = addition_object[0]
    end
    @country = COUNTRY[@obj.country]
    @country_en = @obj.country
    @city_name = @obj.city
  end

  def get_breadcrumb
    case @page_type
    when 'country'
      [{text: '首页', url: '/'}, {text: "#{@country}民宿"}]
    when 'query'
      [{text: '首页', url: '/'}, {text: "#{@country}民宿", url: "/fishtrip/#{@country_en}/"},{text: "#{@city_name}民宿搜索页"}]
    when 'city'
      [{text: '首页', url: '/'}, {text: "#{@country}民宿", url: "/fishtrip/#{@country_en}/"},{text: "#{@city_name}民宿"}]
    when 'detail'
      [{text: '首页', url: '/'}, {text: "#{@country}民宿", url: "/fishtrip/#{@country_en}/"},{text: "#{@country}#{@city_name}民宿", url: "/fishtrip/#{@country_en}/#{@obj.city_en}/"}, {:text=>@obj.name}]
    when 'article'
      [{text: '首页', url: '/'}, {text: "#{@country}民宿", url: "/fishtrip/#{@country_en}/"},{text: "#{@country}#{@city_name}民宿", url: "/fishtrip/#{@country_en}/#{@obj.city_en}/"}, {text: @obj.title}]
    else
      []
    end
  end

  def tdk
    case @page_type
    when 'detail'
      {
        :title=>"#{@obj.name}_#{@city_name}民宿-#{@country}民宿",
        :keywords=>"#{@obj.name},#{@city_name}民宿,#{@country}民宿,住宿",
        :description=>"预订#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
        :h1=>@obj.name
      }
    when 'city'
      {
        :title=>"#{@city_name}民宿_怎么订#{@city_name}民宿-#{@city_name}民宿",
        :keywords=>"#{@city_name}民宿,#{@city_name}民宿预订,住宿",
        :description=>"预订#{@city_name}民宿，#{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
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
        :description=>"预订#{@country}民宿, #{@city_name}自由行住宿，为你推荐#{@pre_desc}。",
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
    return {} unless @country_en
    links = {}
    links[@country_en] = FishtripCity.where(country: @country_en).map do |city|
      { uri: "/fishtrip/#{city.country}/#{city.name_en}/", text: "#{city.name}民宿" }
    end
    links
  end
end
