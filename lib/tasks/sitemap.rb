class Sitemap 
  def initialize(sitemap_type)
    @sitemap_type = sitemap_type
    @date = Time.now.strftime("%Y-%m-%d")
    @year = Time.now.strftime("%Y")
    @xml_path_list = []
  end

  def create_sitemap(product, page_type)
    @file_name_prefix = "public/sitemap/#{@sitemap_type}_#{product}_#{page_type}"
    @template_file = "lib/tasks/#{@sitemap_type}_#{product}_#{page_type}.erb" 
    index=0
    Hotel.find_in_batches(batch_size: 5000) do |hotel_batch|
      res = ERB.new(File.read(@template_file)).result(binding)
      xml_file_name = "#{@file_name_prefix}_#{index}_#{@year}.xml"
      xml_file = File.open(xml_file_name,'w+')
      xml_file.write(res)
      @xml_path_list << xml_file_name
      index += 1
    end
    puts "Sitemap #{product} #{page_type} generated successfully "
  end

  def create_sitemap_index
    @index_file_name = "public/sitemap/#{@sitemap_type}_sitemap_index.xml"
    @template_index= "lib/tasks/#{@sitemap_type}_index.erb" 
    sitemap_index_file = File.new(@index_file_name,"w+")
    res = ERB.new(File.read(@template_index)).result(binding)
    sitemap_index_file.write(res)
  end
end
