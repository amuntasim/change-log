module ChangeLog
  class Base
    include Mongoid::Document
    include Mongoid::Timestamps

    field :version, type: String
    field :author, type: String
    field :message, type: String
    field :time, type: DateTime
    field :tags

    def self.fetch(option)
      all.desc('time')
    end

    def self.last_release
      last
    end
  end
end