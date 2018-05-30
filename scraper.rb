#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

names = {}
names[2015] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2015–2019_kansanedustajista',
  xpath: './/table[.//th[contains(.,"Vaalipiiri")]]//tr[td]/td[1]//a/@title'
)

names[2011] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2011–2015_kansanedustajista',
  xpath: './/table[.//th[contains(.,"Kotikunta")]]//tr[td]/td[1]/a/@title'
)

names[2007] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2007–2011_kansanedustajista',
  xpath: './/table[.//th[contains(.,"Kotikunta")]]//tr[td]/td[1]/a/@title'
)

names[2003] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_2003–2007_kansanedustajista',
  xpath: './/table[.//th[contains(.,"Kotikunta")]]//tr[td]/td[1]/a/@title'
)

names[1999] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1999–2003_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1995] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1995–1999_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1991] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1991–1995_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1987] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1987–1991_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1983] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1983–1987_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1979] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1979–1983_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1975] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1975–1979_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1972] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1972–1975_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names[1970] = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://fi.wikipedia.org/wiki/Luettelo_vaalikauden_1970–1972_kansanedustajista',
  before: '//span[@id="L.C3.A4hteet"]',
  xpath: './/li//a[not(@class="new")][1]/@title'
)

names.each do |term, people|
  raise "Only #{people.count} people for #{term}" unless people.count > 150
end

EveryPolitician::Wikidata.scrape_wikidata(names: { fi: names.values.flatten.uniq }, output: false)
