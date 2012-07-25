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

    it "should work for new streams too" do
      new_stream_attributes = FactoryGirl.attributes_for(:stream)
      new_stream_name = new_stream_attributes[:name]
        
      visit new_item_path
      new_item = fill_in_item
      fill_in "stream_name", with: new_stream_name
      click_button "Create Item"

      visit streams_path
      page.should have_content new_stream_name
      click_link new_stream_name
      page.should have_content new_item[:name]
    end
  end
end

