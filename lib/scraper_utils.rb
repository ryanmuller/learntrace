require 'uri'
require 'net/http'
require 'nokogiri'
require 'image_size'
require 'open-uri'

module ScraperUtils

  # encodes URL in UTF-8, escapes non-standard characters.
  # returns string
  def ScraperUtils.clean_url(url)
    url = url.encode("UTF-8")
    return URI.escape(url)
  end


  def ScraperUtils.get_response_with_redirect(uri)
     # gets page
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"  # enable SSL/TLS
    res = http.start {
      http.request_get(uri.request_uri) {|res|
    }
    }

    if res.code == "301"
      # hope there's no infinite redirect...
      return ScraperUtils.get_response_with_redirect(URI.parse(res.header['location']))
    end

    return res
  end

  # url: url
  # etc...
  # dimension: set to 'true' if you want to get the dimension of an image located at url
  # returns a 2-element array. If dimension = true, returns [height, width]
  # otherwise, returns [content_type, content]
  def ScraperUtils.fetch_url(url, referer = nil, retries = 1, dimension = false)
    cur_try = 0
    p "fetching #{url}"
    nothing = dimension ? nil : [nil, nil]

    # cleans url and parses into URI object
    url = clean_url(url)
    uri = URI.parse(url)

    # checks to make sure you're not using some odd protocol...
    return nothing if !(url.start_with?("http://") || url.start_with?("https://"))

    res = ScraperUtils.get_response_with_redirect(uri)

    content = res.body
    content_type = res['content-type']


    # if unsure of content type, abort!
    return nothing if content_type.nil?

    # if it's an image...
    if content_type.include?('image')

      # use ImageSize library
      image = ImageSize.new(content)

      # if looking for the dimension of the image...
      if dimension && image
        return image.size # return [height, width]
      elsif dimension
        return nothing # if image was null, abort
      end
    elsif dimension # expected an image content-type (because dimension = true), but didn't get one
      return nothing
    end

    # if not looking for an image dimension, just return array of [content_type, content]
    return [content_type, content]
  end



  # gets size of an image. returns [height, width]
  def self.fetch_size(url, referer = nil, retries = 1)
    return fetch_url(url, referer, retries, dimension = true)
  end


  # Class Scraper.
  # TO use, call Scraper.new(url)
  class Scraper
    attr :url, :content, :content_type, :doc
    def initialize(url, og_img = false)
      @url = url
      @og_img = og_img
      @content = nil
      @content_type = nil
      
      # Nokogiri-parsed document
      @doc = nil
    end

    # download the page specified by @url
    def download
      @content_type, @content = ScraperUtils.fetch_url(@url) 
      if @content_type && @content_type.include?('html') && @content
        @doc = Nokogiri::HTML(@content)
      end
    end

    def image_urls
      if @content_type.include?('image')
        yield @url
      elsif @doc
        if @og_img
          og_image = @doc.xpath('//meta[@property="og:image"]').first
          yield og_image.attribute('content').value 
        else
          images = @doc.css('img')
          images.each do |i|
            image_url = URI.join(@url, URI.escape(i['src']))
            yield image_url.to_s
          end
        end

      end
    end

    # get the url of the largest image on the page.
    def largest_image_url
      if !@content
        self.download 
      end

      if !@content || !@content_type
        return nil
      end

      max_area = 0
      max_url = nil

      # step through each <img> object on the page, and calculate size.
      self.image_urls do |image_url|
        size = ScraperUtils.fetch_size(image_url, referer = @url)
        if size.nil?
          next
        end

        p size
        area = size[0]*size[1]

        # ignore little images
        if area < 5000
          p "ignore little #{image_url}"
          next
        end

        # ignore excessively long/wide images
        if size.max / size.min > 1.5
          p "ignore dimensions #{image_url}"
          next
        end

        # penalize images with 'sprite' in their name
        if image_url.to_s.downcase.include?("sprite")
          p "penalizing sprite #{image_url}"
          area /= 10
        end

        if area > max_area
          max_area = area
          max_url = image_url
        end
      end

      # return the url of the image with the largest area
      return max_url
    end

    # get best thumbnail for the page!
    # returns a URL for the image.
    def thumbnail
      image_url = self.largest_image_url
      return image_url
      # the original script does some nice image processing in here, which we can add at a later date
    end


  end

  class YoutubeScraper < Scraper

    def initialize(url)
      super(url)
      @video_id_rx = Regexp.compile('.*v=([A-Za-z0-9\-_]+).*') ## check...
      @thumbnail_template = 'http://img.youtube.com/vi/$video_id/default.jpg'
      @video_id = self.video_id_extract
    end

    def video_id_extract
      vid = @video_id_rx.match(@url)
      video_id = vid[1] unless vid.nil?
      if vid.nil?
        @og_img = true
        video_id = nil
      else
        video_id = vid[1]
      end

      return video_id
    end

    def largest_image_url
      if @og_img
        self.download
        return super
      else
        return @thumbnail_template.sub("$video_id", @video_id)
      end
    end


  end



  class TedScraper < Scraper
    def largest_image_url
      if !@doc
        self.download
      end

      if @doc
        return @doc.css('link[rel=image_src]').first['href']
      end
    end
  end

  class KhanScraper < Scraper
    def largest_image_url
      if !@doc
        self.download
      end
      if @doc
        return @doc.css(".thumb").first['style'].split(/\('|'\)/)[1]
      end
    end
  end



  class CourseraScraper < Scraper
    def initialize(url)
      super(url)
      vid = /\/course\/(\w+)/.match(@url) ## check...
      @video_id = vid.nil? ? nil : vid[1]
      @thumbnail_template = 'https://s3.amazonaws.com/coursera/topics/$video_id/large-icon.png'
    end

    def largest_image_url
      if @video_id.nil?
        return nil
      else
        return @thumbnail_template.sub("$video_id", @video_id)
      end
    end
  end

  class UdacityScraper < Scraper
    def largest_image_url
      if !@content
          self.download
      end

      if @content
        vid = /videoId:\s*'([A-Za-z0-9\-_]+)'/.match(@content)
        thumbnail_template = 'http://img.youtube.com/vi/$video_id/default.jpg'
        img_url = vid.nil? ? nil : thumbnail_template.sub("$video_id", vid[1])
        return img_url
      end
    end
  end

  def self.find_thumb(url)
    dict = {
      "www.ted.com" => proc {|url| return TedScraper.new(url).thumbnail },
      "www.youtube.com" => proc {|url| return YoutubeScraper.new(url).thumbnail },
      "www.khanacademy.org" => proc {|url| return KhanScraper.new(url).thumbnail },
      "www.coursera.org" => proc {|url| return CourseraScraper.new(url).thumbnail },
      "www.udacity.com" => proc {|url| return UdacityScraper.new(url).thumbnail }
    }

    url = ScraperUtils.clean_url(url)
    host = URI.parse(url).host 

    if dict.has_key?(host)
      dict[host].call(url)
    else
      return Scraper.new(url).thumbnail
    end
  end
end
