require "change_log/config"
require "change_log/engine"

module ChangeLog
  # Setup ChangeLog
  def self.config(&block)
    if block_given?
      block.call(ChangeLog::Config)
    else
      ChangeLog::Config
    end
  end
end
