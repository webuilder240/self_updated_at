RSpec.describe SelfUpdatedAt do
  it "has a version number" do
    expect(SelfUpdatedAt::VERSION).not_to be nil
  end

  describe "self_updated_at" do
    context 'set self_updated_at for update columns' do
      let(:test_model) do
        SelfUpdatedAtTestModel.create(title: 'hoge', body: 'fuga', service_updated_at: Time.now - 1.hours)
      end

      let!(:before_update_service_updated_at) { test_model.service_updated_at }

      it 'update title for update service_updated_at column' do
        test_model.update(title: 'hogefuga')
        expect(test_model.service_updated_at.to_s).to eq Time.now.utc.to_s
      end

      it 'update body for not update service_updated_at column' do
        test_model.update(body: 'hogefuga')
        expect(test_model.service_updated_at.to_s).to eq before_update_service_updated_at.to_s
      end
    end
  end
end
