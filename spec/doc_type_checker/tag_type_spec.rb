# frozen_string_literal: true

RSpec.describe DocTypeChecker::TagType do
  let(:tag_type) { described_class.new(tag) }

  describe '#initialize' do
    subject { tag_type }

    context 'when tag_name is return' do
      let(:tag) { YARD::Tags::Tag.new('return', '', ['String']) }

      it { is_expected.to have_attributes(types: [String]) }
    end

    context 'when tag_name is param' do
      let(:tag) { YARD::Tags::Tag.new('param', '', ['String'], 'title') }

      it { is_expected.to have_attributes(types: [String]) }
    end

    context 'when tag_name is option' do
      let(:tag) { YARD::Tags::Tag.new('option', 'title', ['String'], 'options') }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when tag_name is note' do
      let(:tag) { YARD::Tags::Tag.new('note', 'this is note') }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#valid_type' do
    subject { tag_type.valid_type(object) }
    let(:tag) { YARD::Tags::Tag.new('param', '', types) }

    context "when types is ['String']" do
      let(:types) { ['String'] }

      context "when object is 'text'" do
        let(:object) { 'text' }

        it { is_expected.to be_truthy }
      end

      context 'when object is 1' do
        let(:object) { 1 }

        it { is_expected.to be_falsey }
      end
    end

    context "when types is ['Array<String>']" do
      let(:types) { ['Array<String>'] }

      context "when object is ['text']" do
        let(:object) { ['text'] }

        it { is_expected.to be_truthy }
      end

      context "when object is {type: 'text'}" do
        let(:object) { { type: 'text' } }

        it { is_expected.to be_falsey }
      end
    end
  end
end
