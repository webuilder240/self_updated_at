class SelfUpdatedAtTestModel < ActiveRecord::Base
  self_updated_at :service_updated_at, hook_columns: [:title, :body]
end
