require 'httparty'
require 'nokogiri'

module Scrapper
  def parsing(language)
    Nokogiri::HTML(HTTParty.get("https://remoteok.io/remote-#{language}-jobs"))
  end
end