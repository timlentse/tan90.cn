require_relative 'sitemap.rb'
desc "Task for creating sitemap"
task :update_sitemap=>:environment do
  sitemap_obj_fishtrip = Sitemap::Fishtrip.new('pc')
  sitemap_obj_fishtrip.create_sitemap('fishtrip', 'danti')
  sitemap_obj_booking = Sitemap::Booking.new('pc')
  sitemap_obj_booking.create_sitemap('booking', 'city')
  sitemap_obj_booking.create_sitemap('booking', 'review')
  sitemap_obj_booking.create_landmark
  Sitemap.create_sitemap_index('pc')
end

desc "Task for creating sitemap mobile"
task :update_sitemap_mobile=>:environment do
  sitemap_obj = Sitemap::Fishtrip.new('mobile')
  sitemap_obj.create_sitemap('fishtrip', 'danti')
  sitemap_obj.create_sitemap_index
end
