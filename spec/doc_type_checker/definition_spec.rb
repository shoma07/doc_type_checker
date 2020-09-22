# frozen_string_literal: true

RSpec.describe DocTypeChecker::Definition do
  let(:class_objects) { YARD::Registry.load!.all(:class) }
  let(:post_meths) { class_objects[0].meths }
  let(:comment_meths) { class_objects[1].meths }

  describe 'Blog::Post.create' do
    subject { described_class.new(post_meths[0]) }

    it { expect(subject.name).to eq 'Blog::Post.create' }
    it { expect(subject.params[:id]).to have_attributes(types: [Integer]) }
    it { expect(subject.params[:title]).to have_attributes(types: [String]) }
    it { expect(subject.ret).to have_attributes(types: [Blog::Post]) }
  end

  describe 'Blog::Post#initialize' do
    subject { described_class.new(post_meths[1]) }

    it { expect(subject.name).to eq 'Blog::Post#initialize' }
    it { expect(subject.params[:id]).to have_attributes(types: [Integer]) }
    it { expect(subject.params[:title]).to have_attributes(types: [String]) }
    it { expect(subject.params[:comments]).to have_attributes(types: [Array]) }
    it { expect(subject.ret).to have_attributes(types: [Blog::Post]) }
  end

  describe 'Blog::Post#inspect' do
    subject { described_class.new(post_meths[2]) }

    it { expect(subject.name).to eq 'Blog::Post#inspect' }
    it { expect(subject.params).to eq({}) }
    it { expect(subject.ret).to have_attributes(types: [String]) }
  end

  describe 'Blog::Comment#initialize' do
    subject { described_class.new(comment_meths[0]) }

    it { expect(subject.name).to eq 'Blog::Comment#initialize' }
    it { expect(subject.params[:id]).to have_attributes(types: [Integer]) }
    it { expect(subject.params[:body]).to have_attributes(types: [String]) }
    it { expect(subject.ret).to have_attributes(types: [Blog::Comment]) }
  end
end
