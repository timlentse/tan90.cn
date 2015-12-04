require_relative 'sitemap.rb'
desc "Task for creating sitemap"
task :update_sitemap=>:environment do
  sitemap_obj = Sitemap.new
  sitemap_obj.work
  sitemap_obj.create_sitemap_index
end

desc "Task for creating sitemap mobile"
task :update_sitemap_mobile=>:environment do
  sitemap_obj = Sitemap.new
  sitemap_obj.work
  sitemap_obj.create_sitemap_index
end
