# -*- coding: utf-8 -*-
require 'rubygems'
require 'amazon/ecs'
require 'cgi'
require "kconv"

class Book < ActiveRecord::Base
  has_one :image
  before_validation :complete_attributes_from_amazon
  validates_presence_of :title

  def asin
    return isbn_to_asin(self.isbn13)
  end

  def amazon_url
    return "http://www.amazon.co.jp/dp/#{self.asin}"
  end

  private
  def complete_attributes_from_amazon
    isbn = self.isbn13
    return nil unless (isbn.length == 10 || isbn.length == 13)
    return nil if self.id.present? or isbn.blank? or self.title.present?
    amazon_info = retrieve_info_from_amazon(isbn_to_asin(isbn))
    image = Image.create(:path => amazon_info[:image_url])
    amazon_info.delete(:image_url)
    self.update_attributes(amazon_info)
    self.image = image
  end

  def isbn_to_asin(isbn)
    isbn10 = isbn[3..-1]  if isbn.length == 13 # shrink to ISBN10
    asin = isbn10[0..-2] + asin_check_digit(isbn10)

    return asin
  end

  def asin_check_digit(isbn10)
    check_digit, asin_weight = 0, 10

    isbn9 = isbn10[0..-2] # chop the original check digit

    isbn9.each_char do |c|
      check_digit += (c.to_i * asin_weight)
      asin_weight -= 1
    end

    return "0X987654321"[check_digit % 11]
  end


  def retrieve_info_from_amazon(asin)
    items = Amazon::Ecs.item_lookup(asin).first_item
    item = items.get_element('ItemAttributes')

    return nil if (item == nil)

    info = {
      :title     => CGI::unescapeHTML(item.get('Title').toutf8),
      :author    => CGI::unescapeHTML(item.get_array('Author').join(', ').toutf8),
      :publisher => CGI::unescapeHTML(item.get('Publisher').toutf8),
      :isbn13    => item.get('EAN').to_s,
      :price     => item.get('ListPrice/Amount'),
      :page      => item.get("NumberOfPages"),
      :width     => item.get("PackageDimensions/Width"),
      :height    => item.get("PackageDimensions/Height"),
      :depth     => item.get("PackageDimensions/Length"),
      :image_url => items.get_hash('MediumImage')['URL'].toutf8
    }
    return info
  end
end
