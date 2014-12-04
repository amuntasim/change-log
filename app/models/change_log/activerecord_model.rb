module ChangeLog
  class ActiverecordModel < ActiveRecord::Base

    def self.fetch(options)
      self.order('time desc')
    end

    def self.last_release
      last
    end
  end
end