require 'kramdown'
module ChangeLog
  module ApplicationHelper
    def md(string)
      Kramdown::Document.new(string).to_html.html_safe
    end
  end
end
