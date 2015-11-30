# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
#
set :output, "/home/work/hotel.huoche.cn/current/log/crontab.log"
#
every :sunday, :at => '12pm' do
  rake "update_sitemap"
end

# Learn more: http://github.com/javan/whenever
