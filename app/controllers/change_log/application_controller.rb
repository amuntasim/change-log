module ChangeLog
  class ApplicationController < ActionController::Base

    cattr_accessor :authenticator

    before_filter :authenticate_change_log

    def authenticate_change_log
      instance_exec(nil, &self.authenticator) if self.authenticator && self.authenticator.respond_to?(:instance_exec)
    end
  end
end
