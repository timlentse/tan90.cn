module ProxiesHelper
  def human_readable_time_format(time)
    @time_of_second = (Time.now-time).to_i
    case  @time_of_second
    when 0..59
      return "#{@time_of_second}秒前"
    when 60..3599
      return "#{(@time_of_second/60.0).ceil}分钟前"
    when 3600..86399
      return "#{(@time_of_second/3600.0).ceil}小时前"
    when 86400..2591999
      return "#{(@time_of_second/86400.0).ceil}天前"
    when 2592000..31103999
      return "#{(@time_of_second/2592000.0).ceil}月前"
    else 
      return "#{(@time_of_second/31104000.0).ceil}年前"
    end
  end

end
