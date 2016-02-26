module Sitemap
  class Clock

    def initialize(sitemap_type)
      @sitemap_type = sitemap_type
      @date = Time.now.strftime("%Y-%m-%d")
    end

    def create_city
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_clockhotel_city"
      @template_file = "lib/tasks/#{@sitemap_type}_clockhotel_city.erb" 
      index=0
      ClockHotel.uniq.pluck(:city_name_en).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap clockhotel city generated successfully "
    end

    def create_detail
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_clockhotel_detail"
      @template_file = "lib/tasks/#{@sitemap_type}_clockhotel_detail.erb" 
      index=0
      ClockHotel.uniq.pluck(:elong_id).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap clockhotel detail generated successfully "
    end

  end
end
