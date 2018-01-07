RSpec.describe SelfUpdatedAt do
  it "has a version number" do
    expect(SelfUpdatedAt::VERSION).not_to be nil
  end
end
