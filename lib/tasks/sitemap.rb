require_relative 'fishtrip'
require_relative 'booking'
require_relative 'clockhotel.rb'
module Sitemap
  $xml_path_list = []

  def self.create_sitemap_index(sitemap_type)
    index_file_name = "public/sitemap/#{sitemap_type}_sitemap_index.xml"
    template_index= "lib/tasks/#{sitemap_type}_index.erb" 
    sitemap_index_file = File.new(index_file_name,"w+")
    res = ERB.new(File.read(template_index)).result(binding)
    sitemap_index_file.write(res)
  end

end
