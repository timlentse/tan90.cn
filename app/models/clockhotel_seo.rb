class ClockhotelSeo
  def initialize(args = {})
    @args = args
  end

  def get_tdk
    case @args[:page_type]
    when 'detail'
      {
        title: "#{@args[:hotel_name]}钟点房_钟点房预订_钟点房",
        keywords: "钟点房,钟点房预订,#{@args[:city_cn]}钟点房,#{@args[:chain_name]}钟点房",
        description: '',
        h1: @args[:hotel_name]
      }
    when 'list'
      {
        title: "#{@args[:city_cn]}钟点房_钟点房预订_钟点房",
        keywords: "#{@args[:city_cn]}钟点房,#{@args[:city_cn]}钟点房预订",
        description: '',
        h1: "#{@args[:city_cn]}钟点房"
      }
    else
      []
    end
  end

  def get_breadcrumb
    case @args[:page_type]
    when 'detail'
      [{text: '首页',url: "/"},{text: "#{@args[:city_cn]}钟点房",url: "/clockhotel/#{@args[:city_en]}/"},{text: "#{@args[:hotel_name]}钟点房"}]
    when 'list'
      [{text: '首页',url: "/"},{text: "#{@args[:city_cn]}钟点房"}]
    else
      []
    end
  end
end
