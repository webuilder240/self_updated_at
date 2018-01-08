class SelfUpdatedAtTestModelSupportMethod < ActiveRecord::Base
  self_updated_at :service_updated_at, columns: [:title], methods: [:true_method, :false_method]

  def true_method
    true
  end

  def false_method
    false
  end
end
