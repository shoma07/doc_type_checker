# frozen_string_literal: true

RSpec.describe DocTypeChecker::Store do
  let(:store) { described_class.new }

  describe '#fetch' do
    subject { store.fetch('Blog::Post', method_name) }

    context 'when method_name is class method' do
      let(:method_name) { 'create' }

      it { is_expected.to have_attributes(name: 'Blog::Post.create') }
    end

    context 'when method_name is instance method' do
      let(:method_name) { '#inspect' }

      it { is_expected.to have_attributes(name: 'Blog::Post#inspect') }
    end
  end
end
