require 'active_record'
require 'active_record/version'
require 'active_support/core_ext/module'

begin
  require 'rails/engine'
  require 'self_updated_at/engine'
rescue LoadError

end

module SelfUpdatedAt
  extend ActiveSupport::Autoload
end

ActiveSupport.on_load(:active_record) do
  include SelfUpdatedAt::Updatable
end


module SelfUpdatedAt

  module Updatable
    def self.included base
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def self_updated_at(update_column_name, columns: [], methods: [])
      before_save do
        if columns.any?{ |c| send("#{c}_changed?") } || methods.any? { |m| send(m) }
          current_time = self.class.default_timezone == :utc ? Time.now.utc : Time.now
          write_attribute(update_column_name, current_time)
        end
        self
      end
    end
  end
end
