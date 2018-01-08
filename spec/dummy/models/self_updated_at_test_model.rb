class SelfUpdatedAtTestModel < ActiveRecord::Base
  self_updated_at :service_updated_at, columns: [:title]
end
