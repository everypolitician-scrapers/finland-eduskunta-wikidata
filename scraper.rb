#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'

require 'nokogiri'
require 'colorize'
require 'pry'
require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

def noko_for(url)
  Nokogiri::HTML(open(url).read) 
end

def titles_from(url)
  noko = noko_for(url)
  noko.xpath('.//table[tr[contains(.,"Kotikunta")]]//tr[td]/td[1]/a/@title').map(&:text)
end

pages = [
  'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2011%E2%80%932015_kansanedustajista',
  'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2007%E2%80%932011_kansanedustajista',
  'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2003%E2%80%932007_kansanedustajista',
]

titles = pages.map { |p| titles_from(p) }.flatten.uniq
ids = WikiData.ids_from_pages('en', titles)
puts "#{ids.count} records"

ids.values.each_with_index do |id, i|
  puts i if (i % 50).zero?
  data = WikiData::Fetcher.new(id: id).data or next
  ScraperWiki.save_sqlite([:id], data)
end

