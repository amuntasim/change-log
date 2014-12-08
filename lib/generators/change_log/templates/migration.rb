class CreateChangeLogTables < ActiveRecord::Migration
  def self.up
    create_table :<%= [table_prefix, 'change_logs'].compact.join('_') %> do |t|
      t.string   :version, limit: 20
      t.datetime   :time
      t.string   :message, limit: 1000
      t.string   :author, limit: 50
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :<%= [table_prefix, 'change_logs'].compact.join('_') %>, :category

  end

  def self.down
    drop_table :<%=[table_prefix, 'change_logs'].compact.join('_') %>
  end

end