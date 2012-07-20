require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    it "should have some content" do
      visit '/'
      page.should have_content "Learnstream"
    end
  end

  describe "About page" do
    it "should be accessible and have stuff" do
      visit '/'
      click_link "About"
      page.should have_content "About Learnstream"
    end
  end

  describe "Tools page" do

    let(:user) { FactoryGirl.create :user }
    
    it "should be accessible and have stuff" do

      sign_in user
      visit '/'
      click_link 'Tools'
      page.should have_content 'Bookmarklet'
    end
  end
end
