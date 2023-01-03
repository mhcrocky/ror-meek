require 'rails_helper'

describe 'Article', type: :request do
  describe 'GET' do
    let!(:article1)   { create :article, name: 'Article1' }
    let!(:article2)   { create :article, name: 'Article2' }

    let!(:post1)      { create :post, name: 'Post1', article: article1, release_date: 'Mon, 09 May 2022' }
    let!(:post2)      { create :post, name: 'Post2', article: article1, release_date: 'Mon, 16 Aug 2021' }
    let!(:post3)      { create :post, name: 'Post3', article: article2 }
    let!(:post4)      { create :post, name: 'Post4', article: article2 }

    it 'returns all articles' do
      get '/api/articles.json'
      expect(json[0][:name]).to eq('Article1')
      expect(json[1][:name]).to eq('Article2')
    end

    it 'returns first article' do
      get "/api/articles/#{article1.id}.json"
      expect(json[:name]).to eq('Article1')
    end

    it 'returns all posts' do
      get "/api/articles/#{article1.id}/posts.json"
      expect(json[:data][0][:name]).to eq('Post1')
      expect(json[:data][1][:name]).to eq('Post2')
    end

    it 'returns first post' do
      get "/api/articles/#{article1.id}/posts/#{post1.id}.json"
      expect(json[:name]).to eq('Post1')
    end
  end
end
