# -*- coding: utf-8 -*-
module ApplicationHelper
  # common以下のテンプレートの省略表記
  def tc(type, template, options = {})
    return t("common." + type + "." + template, options)
  end

  # activerecord以下のテンプレートの省略表記
  def tm(model, template)
    return t("activerecord.attributes." + model + "." + template)
  end
end
