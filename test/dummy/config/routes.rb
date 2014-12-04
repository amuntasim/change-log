Rails.application.routes.draw do

  mount ChangeLog::Engine => "/change_log"
end
