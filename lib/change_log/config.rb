require 'active_support/core_ext/class/attribute_accessors'

module ChangeLog
  module Config
    class << self
      # Table prefix to avoid collision
      attr_accessor :table_prefix

      #layout name default applocation
      attr_accessor :layout

      #commit message prefix
      attr_accessor :commit_prefix

      attr_accessor :orm

      attr_accessor :tag_prefix

      attr_accessor :tag_filter_enabled

      def reset
        @layout = 'change_log/application'
        @table_prefix = nil
        @commit_prefix = '~~~'
        @tag_prefix = '~~'
        @tag_filter_enabled = true
      end
    end

    # Set default values for configuration options on load
    self.reset
  end
end
