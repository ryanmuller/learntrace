require 'spec_helper'

describe "Forks" do
  let!(:creator) { FactoryGirl.create(:user, name: "Course creator") }
  let!(:user) { FactoryGirl.create(:user, name: "Learner" ) }
  let!(:source) { FactoryGirl.create(:stream, user: creator) }
  let!(:item) { FactoryGirl.create(:item) }
  let!(:target) { FactoryGirl.create(:stream, user: user) }
  let!(:pin) { FactoryGirl.create(:due_today_pin, user: user, item: item, stream: source) }

  before { sign_in user }

  describe "create fork" do

    it "should create a fork and copy the items" do
      visit stream_path(source)
      click_button "Start the flow!"
      page.should have_content target.name
      page.should have_content item.name
    end
  end

  describe "create fork for new stream" do
    it "should create the new stream, a fork to it, and copy the items" do
      visit stream_path(source)
      fill_in "new_stream", with: "New stream"
      click_button "Start the flow!"
      page.should have_content "New stream"
      page.should have_content item.name
    end
  end

  describe "create item in source" do

    it "should be copied to the target" do
      visit stream_path(source)
      click_button "Start the flow!"
      sign_out

      sign_in creator
      visit stream_path(source)
      new_item = {}
      within("#new_item") do
        new_item = fill_in_item
        click_button "Create Item"
      end
      sign_out

      sign_in user
      visit stream_path(target)
      page.should have_content(new_item[:name])
    end
  end

  describe "deleting a fork" do

    it "should stop showing the fork", js: true do
      visit stream_path(source)
      click_link "Fork Me!"
      click_button "Start the flow!"

      visit stream_path(target)
      click_link "Settings"
      page.should have_content(source.name)
      click_link "Remove this fork"
      page.driver.browser.switch_to.alert.accept
      page.should_not have_content(source.name)
    end
  end
end
