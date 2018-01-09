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
      before_create do
        current_time = self.class.default_timezone == :utc ? Time.now.utc : Time.now
        write_attribute(update_column_name, current_time) if eval("#{update_column_name}.nil?")
        self
      end
      before_update do
        current_time = self.class.default_timezone == :utc ? Time.now.utc : Time.now
        # for ActiveRecord ~> 5.1
        if Gem::Version.new(ActiveRecord.version) >= Gem::Version.new('5.1')
          columns_changed = columns.any? { |c| will_save_change_to_attribute?(c)  }
        else
          columns_changed = columns.any? { |c| attribute_changed?(c)  }
        end
        if (columns_changed || methods.any? { |m| send(m) })
          write_attribute(update_column_name, current_time)
        end
        self
      end
    end
  end
end
