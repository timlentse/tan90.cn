require 'httparty'
require 'nokogiri'
require 'pry'
require 'json'
require_relative 'config'

class FishTrip
  include HTTParty
  base_uri 'http://www.fishtrip.cn/'

  def initialize
    @key = Db::KEY
    get_response = self.class.get('/login')
    get_response_cookie = get_response.headers['Set-Cookie']
    post_response = self.class.post(
      '/sessions',
      body: {
        "cellphone_code"=> '0086',
        "user[cellphone]"=>Db::ACCOUNT,
        "user[password]"=>Db::PASS
      },
      headers: {'Cookie'=>get_response_cookie }
    )
    @cookie = post_response.headers['Set-Cookie']
  end

  def fetch_cities
    page_body = self.class.get('/', headers: {'Cookie' => @cookie}).body
    @page = Nokogiri::HTML(page_body)
    @page.xpath('//span[@class="cpane__city"]/a').each do |link|
      uri_spl = link['href'].split('/')
      city = { 
        :name=>link.text,
        :name_en=>uri_spl[2],
        :country=>uri_spl[1]
      }
      @city = Db::City.find_by(:name_en=>uri_spl[1])
      @city.nil? ? Db::City.new(city).save : @city.update(city)
    end
  end

  def get_hotel_list
    Db::City.find_each do |city|
      begin 
        @page = 1
        while 1 
          uri = "/#{city.country}/#{city.name_en}/?page=#{@page}"
          puts uri
          @hotels = parse_hotel_list_page(uri, city) 
          @hotels.each do |hotel_hash|
            @hotel = Db::Hotel.where(:fishtrip_hotel_id=>hotel_hash[:fishtrip_hotel_id]).take
            @hotel.nil? ? Db::Hotel.new(hotel_hash).save : @hotel.update(hotel_hash)
          end
          break if @hotels.empty?
          @page+=1
        end
      rescue=>e
        warn e 
        next 
      end
    end
  end

  def fetch_shared_uri
    Db::Hotel.find_each do |hotel|
      @shared_uri = "http://www.fishtrip.cn#{hotel.uri}?referral_id=587681955"
      hotel.update(:shared_uri=>@shared_uri)
    end
  end

  def fetch_country
    @hotel_hash = {}
    ['taiwan', 'japan', 'thailand', 'korea'].each do |country|
      @uri = "http://www.fishtrip.cn/#{country}/"
      @hotels_div = Nokogiri::HTML(self.class.get(@uri, headers: {'Cookie'=>@cookie}).body).css('div.hilist__item.fltriple__item')
      @hotel_ids = []
      break if @hotels_div.empty?
      @hotels_div.each do |hotel_div|
        @hotel_info_div = hotel_div.css('div.hihitem__row.house-item-info').xpath('div')
        uri = @hotel_info_div[0].xpath('span/a')[0]['href']
        @hotel_ids.push(uri[/\d+/])
      end
      @hotel_hash[country] = {:ids=>@hotel_ids}
    end
    puts @hotel_hash
  end

  def fetch_all_images
    Db::Hotel.find_each do |hotel|
      next unless hotel.image_uri
      `wget #{hotel.image_uri} -O images/#{hotel.fishtrip_hotel_id}.jpg`
    end
  end

  def parse_hotel_list_page(uri, city)
    @hotels_div = Nokogiri::HTML(self.class.get(uri, headers: {'Cookie'=>@cookie}).body).css('div.hilist__item.fltriple__item')
    @hotels_div.map do |hotel_div|
      @image_tag = hotel_div.css('div.hihitem__row.house-item').xpath('div/a/img')[0]
      @hotel_info_div = hotel_div.css('div.hihitem__row.house-item-info').xpath('div')
      name = @hotel_info_div[0].xpath('span/a')[0].text
      uri = @hotel_info_div[0].xpath('span/a')[0]['href']
      price = @hotel_info_div[0].xpath('span[@class="hiinfo__price"]').text
      comment = @hotel_info_div[1].css('span.hiinfo__rate-salse').text
      address = @hotel_info_div[2].css('span.hiinfo__location').text
      {
        :name=>name,
        :uri=>uri,
        :image_uri=>@image_tag['data-original'],
        :price=>price[/\d+/],
        :comment=>comment,
        :address=>address,
        :city_id=>city.id,
        :city=>city.name,
        :city_en=>city.name_en,
        :country=>city.country,
        :fishtrip_hotel_id=>uri[/\d+/],
      }
    end
  end

  def test_list
    city= Db::City.where(:name_en=>'daban').take
    p parse_hotel_list_page('/japan/daban/?page=1', city)
  end

  def craw_comment
    # Hotel.all.reject{|hotel| !hotel.score.nil?}.each do |hotel|
    Db::Hotel.find_each do |hotel|
      begin
        # next if Comment.find_by(:hotel_id=>hotel.fishtrip_hotel_id)
        @page_content = Nokogiri::HTML(self.class.get(hotel.uri, headers: {'Cookie'=>@cookie}).body)
        @tuijian = @page_content.css('div.hsgood__item').map{|tui| tui.text}.to_json
        @traffic = @page_content.css('div.hslocation__content')[1].text
        hotel.update(tuijian: @tuijian, traffic: @traffic)
        # @comments =  @page_content.css('div.house-rates-item.js_house_rate_item')
        # @desc = @page_content.css('div.hssection__wrap')[0].text.gsub(/[[:space:]]/,'')
        # @avg_score = @page_content.css('span.hrstat__score').text.gsub(/[[:space:]]/,'')

        # @comments.each do |comment|
        #   content = comment.css('div.hritem__content-word p').text.gsub(/[[:space:]]/,'')
        #   author = comment.css('span.hritem__content-bold').text.gsub(/[[:space:]]/,'')
        #   score = comment.css('span.js_house_rate_score').text.gsub('分', '')
        #   comment_time = comment.css('p.hritem__info-gray.js_house_rate_start_day').text.gsub('入住', '').gsub(/[[:space:]]/,'')
        #   Comment.new(hotel_id: hotel.fishtrip_hotel_id, content: content, author: author, score: score, comment_time: comment_time).save
        #   hotel.update(desc: @desc, score: @avg_score)
        # end
        # large_image_url = @page_content.css('div.hsphotos__item.js_hphotos_list_item img')[0]['data-lazy']
        # `wget #{large_image_url} -O images/#{hotel.fishtrip_hotel_id}-large.jpg`
      rescue=>e
        warn e
        next
      end
    end
  end

  def test
    page = self.class.get('/houses/hm10527547203/', headers: {'Cookie'=>@cookie}).body
    puts page
  end

end

fishtrip = FishTrip.new
# fishtrip.test_list
fishtrip.get_hotel_list
# fishtrip.test
# fishtrip.fetch_shared_uri
# fishtrip.fetch_country
# fishtrip.fetch_all_images
# fishtrip.craw_comment
