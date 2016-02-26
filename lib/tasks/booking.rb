module Sitemap
  class Booking

    def initialize(sitemap_type)
      @sitemap_type = sitemap_type
      @date = Time.now.strftime("%Y-%m-%d")
    end

    def create_city
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_booking_city"
      @template_file = "lib/tasks/#{@sitemap_type}_booking_city.erb" 
      index=0
      BookingHotel.uniq.pluck(:cc1, :city_unique).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap booking city generated successfully "
    end

    def create_review
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_booking_review"
      @template_file = "lib/tasks/#{@sitemap_type}_booking_review.erb" 
      index=0
      BookingHotel.uniq.pluck(:cc1, :city_unique).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap booking review generated successfully "
    end

    def create_landmark
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_booking_landmark"
      @template_file = "lib/tasks/#{@sitemap_type}_booking_landmark.erb" 
      index=0
      BookingLandmark.where("hotels!=''").uniq.pluck(:id).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap booking landmark generated successfully "
    end

    def create_detail
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_booking_detail"
      @template_file = "lib/tasks/#{@sitemap_type}_booking_detail.erb" 
      index=0
      BookingHotel.uniq.pluck(:id).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap booking detail generated successfully "
    end

    def create_airport
      @file_name_prefix = "public/sitemap/#{@sitemap_type}_booking_airport"
      @template_file = "lib/tasks/#{@sitemap_type}_booking_airport.erb" 
      index=0
      BookingAirport.where("hotels!=''").uniq.pluck(:iata).each_slice(5000) do |hotel_batch|
        res = ERB.new(File.read(@template_file)).result(binding)
        xml_file_name = "#{@file_name_prefix}_#{index}.xml"
        xml_file = File.open(xml_file_name,'w+')
        xml_file.write(res)
        $xml_path_list << xml_file_name
        index += 1
      end
      puts "Sitemap booking airport generated successfully "
    end

  end
end
