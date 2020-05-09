require 'spec_helper'

describe "Magazine App" do
  let(:article_title) { "Hello World" }
  let(:article_content) { "This is my first article!!!" }

  before do
    @article1 = Article.create(:title => article_title, :content => article_content)
    @article2 = Article.create(:title => "second article", :content => "I'm a really good writer")
  end

  describe "Create Action" do

    it "creates a new article" do
      visit '/articles/new'

      fill_in :title, :with => "my favorite article"
      fill_in :content, :with => "content!!!!"

      page.find(:css, "[type=submit]").click

      expect(Article.all.count).to eq(3)
      expect(Article.last.title).to eq("my favorite article")
    end

    it "redirects to '/articles/:id'" do
      visit '/articles/new'

      fill_in :title, :with => "an article"
      fill_in :content, :with => "content content content content content"

      page.find(:css, "[type=submit]").click

      expect(page.current_path).to eq("/articles/#{Article.last.id}")
      expect(page.body).to include("content content content content content")
    end

  end

  describe "Read Action " do
    describe 'index action' do
      it 'responds with a 200 status code' do
        get "/articles"
        expect(last_response.status).to eq(200)
      end

      it "displays all the articles" do
        get "/articles"
        expect(last_response.body).to include(article_title)
        expect(last_response.body).to include(@article2.title)
      end
    end

    describe 'show action' do
      it 'show page responds with a 200 status code' do
        get "/articles/#{@article1.id}"
        expect(last_response.status).to eq(200)
      end

      it "show page displays the article's title" do
        get "/articles/#{@article1.id}"
        expect(last_response.body).to include(article_title)
      end

      it "show page displays the article's content" do
        get "/articles/#{@article1.id}"
        expect(last_response.body).to include(article_content)
      end
    end


 end