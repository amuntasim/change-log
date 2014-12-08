require 'kramdown'
module ChangeLog
  module ApplicationHelper
    def md(string)
      Kramdown::Document.new(string, parse_block_html: true).to_html.html_safe
    end
  end
end
