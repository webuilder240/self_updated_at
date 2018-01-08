RSpec.describe SelfUpdatedAt do
  it "has a version number" do
    expect(SelfUpdatedAt::VERSION).not_to be nil
  end

  describe "self_updated_at" do

    context 'self_updated_at for nil service_updated_at' do
      let(:test_model) do
        SelfUpdatedAtTestModelTrueMethod.create(title: 'hoge', body: 'fuga')
      end
      it 'set service_updated_at Time.now' do
        expect(test_model.service_updated_at.to_s).to eq Time.now.utc.to_s
      end
    end

    context 'support self_updated_at for true methods' do
      let(:test_model) do
        SelfUpdatedAtTestModelTrueMethod.create(title: 'hoge', body: 'fuga', service_updated_at: Time.now - 1.hours)
      end

      it 'call true_method' do
        test_model.update(title: 'fuga')
        expect(test_model.service_updated_at.to_s).to eq Time.now.utc.to_s
      end
    end

    context 'support self_updated_at for false methods' do
      let(:test_model) do
        SelfUpdatedAtTestModelFalseMethod.create(title: 'hoge', body: 'fuga', service_updated_at: Time.now.utc - 1.hours)
      end
      it 'call false_method' do
        expect(test_model.service_updated_at.to_s).to eq (Time.now.utc - 1.hours).to_s
      end
    end

    context 'support self_updated_at for multiple methods' do
      let(:test_model) do
        SelfUpdatedAtTestModelBothMethod.create(title: 'hoge', body: 'fuga', service_updated_at: Time.now - 1.hours)
      end

      it 'call true_method and false_method' do
        test_model.update(title: 'fuga')
        expect(test_model.service_updated_at.to_s).to eq Time.now.utc.to_s
      end
    end

    context 'set self_updated_at for update columns and true_method' do
      let(:test_model) do
        SelfUpdatedAtTestModelBothMethod.create(title: 'hoge', body: 'fuga', service_updated_at: Time.now - 1.hours)
      end

      it 'call true_method and change body method' do
        test_model.update(body: 'hogefuga')
        expect(test_model.service_updated_at.to_s).to eq Time.now.utc.to_s
      end
    end

    context 'set self_updated_at for update columns and false_method' do
      let(:test_model) do
        SelfUpdatedAtTestModelColumnsAndFalseMethod.create(title: 'hoge', body: 'fuga', service_updated_at: Time.now - 1.hours)
      end

      let!(:before_update_service_updated_at) { test_model.service_updated_at }

      it 'call false_method and change body method' do
        test_model.update(body: 'hogefuga')
        expect(test_model.service_updated_at.to_s).to eq before_update_service_updated_at.to_s
      end

      it 'call false_method and change title' do
        test_model.update(title: 'hogefuga')
        expect(test_model.service_updated_at.to_s).to eq Time.now.utc.to_s
      end
    end

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
