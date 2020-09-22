# frozen_string_literal: true

RSpec.describe DocTypeChecker::TracePoint do
  it do
    expect { Blog::Post.new('title', 1, []) }.to raise_error(DocTypeChecker::Error)
  end

  it do
    expect { Blog::Post.new(1, 'title', []).id_to_string }.to raise_error(DocTypeChecker::Error)
  end

  it { expect(Blog::Post.new(1, 'title', []).id_to_integer).to eq 1 }
end
