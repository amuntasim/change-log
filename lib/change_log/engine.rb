module ChangeLog
  class Engine < ::Rails::Engine
    isolate_namespace ChangeLog
    initializer 'change_log.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper ChangeLog::ApplicationHelper
      end
    end
  end
end
