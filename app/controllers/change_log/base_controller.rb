module ChangeLog
  class BaseController < ChangeLog::ApplicationController
    layout ChangeLog.config.layout

    def index
      @items = _model.fetch(params)
    end

    def _model
      if ChangeLog.config.orm == 'activerecord'
        @change_log_model = ChangeLog::ActiverecordModel
      else
        @change_log_model = ChangeLog::MongoidModel
      end
    end
  end
end