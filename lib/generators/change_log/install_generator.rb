require 'rails/generators'
require File.expand_path('../utils', __FILE__)

# http://guides.rubyonrails.org/generators.html
# http://rdoc.info/github/wycats/thor/master/Thor/Actions.html
# keep generator idempotent, thanks
# Thanks to https://github.com/sferik/rails_admin !

module ChangeLog
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)
    include Rails::Generators::Migration
    include Generators::Utils::InstanceMethods
    extend Generators::Utils::ClassMethods

    argument :_namespace, :type => :string, :required => false, :desc => "ChangeLog url namespace"
    argument :_table_prefix, :type => :string, :required => false, :desc => "Prefix for change_log tables "
    argument :_orm, :type => :string, :required => false, :desc => "ORM <activerecord or mongoid>"
    desc "ChangeLog installation generator"

    def install
      routes = File.open(Rails.root.join("config/routes.rb")).try :read
      initializer = (File.open(Rails.root.join("config/initializers/change_log.rb")) rescue nil).try :read

      display "Hello, ChangeLog installer will help you sets things up!", :black
      unless initializer
        #install_generator = ask_boolean("Do you want to install the optional configuration file (to change mappings, locales dump location etc..) ?")
        @orm = multiple_choice "Please select orm", [["ActiveRecord", "activerecord"], ["Mongoid", "mongoid"]]

        _table =  @orm == 'mongoid' ? 'collection' : 'table'
        @table_prefix = ask_for("Do you want to add #{_table} prefix?", nil, table_prefix)
        template "initializer.erb", "config/initializers/change_log.rb"
      else
        display "You already have a config file. generating a new 'change_log.rb.example' that you can review."
        template "initializer.erb", "config/initializers/change_log.rb.example"
      end

      if @orm == 'activerecord'
        display "Adding a migration..."
        migration_template 'migration.rb', 'db/migrate/create_change_log_tables.rb' #rescue display $!.message
      end

      namespace = ask_for("Where do you want to mount change_log?", "change_log", _namespace)
      gsub_file "config/routes.rb", /mount ChangeLog::Engine => \'\/.+\', :as => \'change_log\' if defined\? ChangeLog/, ''
      gsub_file "config/routes.rb", /mount ChangeLog::Engine => \'\/.+\', :as => \'change_log\'/, ''
      gsub_file "config/routes.rb", /mount ChangeLog::Engine => \'\/.+\'/, ''
      route("mount ChangeLog::Engine => '/#{namespace}', :as => 'change_log' if defined? ChangeLog")

      display "Job's done: migrate,now modify initilizer[optional],  start your server and visit '/#{namespace}'!", :blue
    end

    def table_prefix
      @table_prefix
    end
  end
end