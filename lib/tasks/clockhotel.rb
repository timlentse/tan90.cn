module Sitemap
  class Clock

    def initialize(sitemap_type)
      @sitemap_type = sitemap_type
      @date = Time.now.strftime("%Y-%m-%d")
    end

    def create_sitemap(product, page_type)
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_#{product}_#{page_type}"
      @template_file = "lib/tasks/#{@sitemap_type}_#{product}_#{page_type}.erb" 
      index=0
      ClockHotel.uniq.pluck(:city_name_en).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap #{product} #{page_type} generated successfully "
    end

  end
end
