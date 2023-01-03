require 'rails_helper'

describe UploadInitialPostsService do
  let(:dump)             { Rails.root.join('spec', 'support', 'attachments', 'posts.csv').to_s }
  let(:article_category) { create :category, kind: 2 }
  let(:article)          { create :article, category_id: article_category.id }

  it 'upload initial posts from CSV file' do
    expect { described_class.initial_posts(dump, article) }.to change {
      article.posts.count
    }.from(0).to(2)

    expect(article.posts.first.name).to eq('First post')
    expect(article.posts.second.name).to eq('Second post')
  end
end
