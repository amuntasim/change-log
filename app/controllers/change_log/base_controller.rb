module ChangeLog
  class BaseController < ChangeLog::ApplicationController
    layout ChangeLog.config.layout

    def index
      @items = ChangeLog::Base.fetch(params)
    end
  end
end