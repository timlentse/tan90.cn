module Sitemap
  class Booking

    def initialize(sitemap_type)
      @sitemap_type = sitemap_type
      @date = Time.now.strftime("%Y-%m-%d")
    end

    def create_sitemap(product, page_type)
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_#{product}_#{page_type}"
      @template_file = "lib/tasks/#{@sitemap_type}_#{product}_#{page_type}.erb" 
      index=0
      BookingHotel.uniq.pluck(:cc1, :city_unique).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap #{product} #{page_type} generated successfully "
    end

    def create_landmark
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_booking_landmark"
      @template_file = "lib/tasks/#{@sitemap_type}_booking_landmark.erb" 
      index=0
      BookingLandmark.find_in_batches(:batch_size=>5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap booking landmark generated successfully "
    end

  end
end
