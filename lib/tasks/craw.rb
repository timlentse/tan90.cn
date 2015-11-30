require 'httparty'
require 'nokogiri'
require_relative './dbconfig'

class FishTrip
  include HTTParty
  base_uri 'http://www.fishtrip.cn/'

  def initialize
    get_response = self.class.get('/login')
    get_response_cookie = get_response.headers['Set-Cookie']
    post_response = self.class.post(
      '/sessions',
      body: {
        "cellphone_code"=> '0086',
        "user[cellphone]"=>"18610294180",
        "user[password]"=>"xiejinglun199283"
      },
      headers: {'Cookie' => get_response_cookie }
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
      @city = City.find_by(:name_en=>uri_spl[1])
      @city.nil? ? City.new(city).save : @city.update(city)
    end
  end

  def test
    page = self.class.get('/houses/hm10527547203/', headers: {'Cookie'=>@cookie}).body
    puts page
  end

  def get_hotel_list
    City.find_each do |city|
      begin 
        @page = 1
        while 1 
          @uri = "/#{city.country}/#{city.name_en}/?page=#{@page}"
          @hotels_div = Nokogiri::HTML(self.class.get(@uri, headers: {'Cookie'=>@cookie}).body).css('div.hilist__item.fltriple__item')
          break if @hotels_div.empty?
          @hotels_div.each do |hotel_div|
            @image_tag = hotel_div.css('div.hihitem__row.house-item').xpath('div/a/img')[0]
            @hotel_info_div = hotel_div.css('div.hihitem__row.house-item-info').xpath('div')
            name = @hotel_info_div[0].xpath('span/a')[0].text
            uri = @hotel_info_div[0].xpath('span/a')[0]['href']
            price = @hotel_info_div[0].xpath('span[@class="hiinfo__price"]').text
            comment = @hotel_info_div[1].css('span.hiinfo__rate-salse').text
            address = @hotel_info_div[2].css('span.hiinfo__location').text
            hotel_hash = {
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
            @hotel = Hotel.find_by(:uri=>uri)
            @hotel.nil? ? Hotel.new(hotel_hash).save : @hotel.update(hotel_hash)
          end
          @page+=1
        end
      rescue=>e
        warn e 
        next 
      end
    end
  end

  def fetch_shared_uri
    Hotel.find_each do |hotel|
      # @page_content = Nokogiri::HTML(self.class.get(hotel.uri, headers: {'Cookie'=>@cookie}).body)
      # @shared_uri = @page_content.css('div.smodal__content em')
      # hotel.update(:shared_uri=>@shared_uri.text)
      @shared_uri = "http://www.fishtrip.cn#{hotel.uri}?referral_id=587681955"
      hotel.update(:shared_uri=>@shared_uri)
    end
  end

  def fetch_country
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
      hotel_hash = {
        :name=>country,
        :ids=>@hotel_ids
      }
      puts hotel_hash
    end
  end

  def fetch_all_images
    Hotel.find_each do |hotel|
      next unless hotel.image_uri
      `wget #{hotel.image_uri} -O images/#{hotel.id}.jpg`
    end
  end
end

fishtrip = FishTrip.new
# fishtrip.get_hotel_list
# fishtrip.test
fishtrip.fetch_shared_uri
# fishtrip.fetch_country
# fishtrip.fetch_all_images
