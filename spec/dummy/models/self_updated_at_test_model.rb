class SelfUpdatedAtTestModel < ActiveRecord::Base
  self_updated_at :service_updated_at, columns: [:title]

  private

  def true_method
    true
  end

  def false_method
    false
  end
end

class SelfUpdatedAtTestModelTrueMethod < SelfUpdatedAtTestModel
  self_updated_at :service_updated_at, methods: [:true_method]
end

class SelfUpdatedAtTestModelFalseMethod < SelfUpdatedAtTestModel
  self_updated_at :service_updated_at, methods: [:false_method]
end

class SelfUpdatedAtTestModelBothMethod < SelfUpdatedAtTestModel
  self_updated_at :service_updated_at, methods: [:false_method, :true_method]
end

class SelfUpdatedAtTestModelColumnsAndMethod < SelfUpdatedAtTestModel
  self_updated_at :service_updated_at, columns: [:title], methods: [:true_method]
end

class SelfUpdatedAtTestModelColumnsAndFalseMethod < SelfUpdatedAtTestModel
  self_updated_at :service_updated_at, columns: [:title], methods: [:false_method]
end
