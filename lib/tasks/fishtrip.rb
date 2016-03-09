module Sitemap
  class Fishtrip

    def initialize(sitemap_type)
      @sitemap_type = sitemap_type
      @date = Time.now.strftime("%Y-%m-%d")
    end

    def create_sitemap
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_fishtrip_city"
      @template_file = "lib/tasks/#{@sitemap_type}_fishtrip_city.erb" 
      index=0
      FishtripCity.find_in_batches(batch_size: 5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap fishtrip city generated successfully "

      @file_name_prefix = "public/sitemap/#{@sitemap_type}_fishtrip_danti"
      @template_file = "lib/tasks/#{@sitemap_type}_fishtrip_danti.erb" 
      index=0
      FishtripHotel.find_in_batches(batch_size: 5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap fishtrip danti generated successfully "
    end

  end
end
