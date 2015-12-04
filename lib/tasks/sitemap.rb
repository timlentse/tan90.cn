class Sitemap 
  def initialize(sitemap_type=nil)
    @sitemap_type = sitemap_type
    @date = Time.now.strftime("%Y-%m-%d")
    @year = Time.now.strftime("%Y")
    @file_name_prefix = "public/sitemap/#{@sitemap_type}fishtrip_danti"
    @index_file_name = "public/sitemap/sitemap#{@sitemap_type}_index.xml"
    @header = %Q(<?xml version="1.0" encoding="UTF-8" ?>\n <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n)
    @xml_path_list = []
  end

  def work
    index=0
    Hotel.find_in_batches(batch_size: 5000) do |hotel_batch|
      xml_file_name = "#{@file_name_prefix}_#{index}_#{@year}.xml"
      write_items_to_file(hotel_batch, xml_file_name)
      index+=1
    end
    puts "Danti generated successfully "
  end

  def write_items_to_file(hotel_batch, file_name)
    xml_file = File.new(file_name,"w+")
    xml_file.write(@header)
    hotel_batch.each do |hotel|
      if @sitemap_type=='mobile'
        url = "http://m.timlentse.com/#{hotel.fishtrip_hotel_id}/"
      else
        url = "http://hotel.timlentse.com/#{hotel.fishtrip_hotel_id}/"
      end
      item=<<EOF
  <url>
    <loc>#{url}</loc>
    <lastmod>#{@date}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
EOF
      xml_file.write(item)
    end
    xml_file.write("</urlset>\n")
    xml_file.close
    @xml_path_list << file_name
  end

  def create_sitemap_index
    sitemap_index = File.new(@index_file_name,"w+")
    sitemap_index.write(%Q(<?xml version="1.0" encoding="UTF-8"?>\n <sitemapindex>\n))
    @xml_path_list.each do |file|
      file = file.gsub(/public\/sitemap\//, '')
      sitemap_item=<<EOF
  <sitemap> 
    <loc>
      http://hotel.huoche.cn/sitemap/#{file}
    </loc>
  </sitemap>
EOF
      sitemap_index.write(sitemap_item)
    end
    sitemap_index.write("</sitemapindex>\n")
    sitemap_index.close
  end

end
