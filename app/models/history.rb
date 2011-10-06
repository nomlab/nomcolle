# -*- coding: utf-8 -*-
class History < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  def self.action_list
    return ["蔵書登録", "購入希望","注文", "借り出し", "返却","破棄","その他"]
  end
end
