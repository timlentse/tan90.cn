require_relative 'sitemap.rb'
desc "Task for creating sitemap"
task :update_sitemap=>:environment do
  sitemap_obj_fishtrip = Sitemap::Fishtrip.new('pc')
  sitemap_obj_fishtrip.create_sitemap('fishtrip', 'danti')
  sitemap_obj_booking = Sitemap::Booking.new('pc')
  sitemap_obj_booking.create_city
  sitemap_obj_booking.create_review
  sitemap_obj_booking.create_landmark
  sitemap_obj_booking.create_airport
  sitemap_obj_booking.create_detail
  sitemap_obj_clockhotel = Sitemap::Clock.new('pc')
  sitemap_obj_clockhotel.create_city
  sitemap_obj_clockhotel.create_detail
  Sitemap.create_sitemap_index('pc')
end

desc "Task for creating sitemap mobile"
task :update_sitemap_mobile=>:environment do
  sitemap_obj_fishtrip = Sitemap::Fishtrip.new('mobile')
  sitemap_obj_fishtrip.create_sitemap('fishtrip', 'danti')
  sitemap_obj_booking = Sitemap::Booking.new('mobile')
  sitemap_obj_booking.create_city
  sitemap_obj_booking.create_review
  sitemap_obj_booking.create_landmark
  sitemap_obj_booking.create_airport
  sitemap_obj_booking.create_detail
  sitemap_obj_clockhotel = Sitemap::Clock.new('mobile')
  sitemap_obj_clockhotel.create_city
  sitemap_obj_clockhotel.create_detail
  Sitemap.create_sitemap_index('mobile')
end

