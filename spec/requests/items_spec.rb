require 'spec_helper'

describe 'Items' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:stream) { FactoryGirl.create(:stream, user: user) }

  before { sign_in user }

  describe "add item" do
    it "should create an item and pin it to a stream" do
      visit new_item_path
      new_item = fill_in_item
      select stream.name, from: "Stream"
      click_button "Create Item"

      visit stream_path(stream)
      page.should have_content new_item[:name]
    end
  end
end

