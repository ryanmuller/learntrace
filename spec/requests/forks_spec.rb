require 'spec_helper'

describe "Forks" do
  let!(:creator) { FactoryGirl.create(:user, name: "Course creator") }
  let!(:user) { FactoryGirl.create(:user, name: "Learner" ) }
  let!(:source) { FactoryGirl.create(:stream, user: creator) }
  let!(:item) { FactoryGirl.create(:item) }
  let!(:target) { FactoryGirl.create(:stream, user: user) }
  let!(:pin) { FactoryGirl.create(:due_today_pin, user: creator, item: item, stream: source) }

  def create_fork
    visit stream_path(source)
    click_link "Select stream"
    click_link target.name
  end

  before { sign_in user }

  describe "create fork" do

    it "should create a fork and copy the items", js: true do
      create_fork
      page.should have_css('h1', text: target.name)
      page.should have_content item.name
    end
  end

  describe "create fork for new stream", js: true do
    it "should create the new stream, a fork to it, and copy the items" do
      visit stream_path(source)
      click_link "Select stream"
      fill_in "new_stream", with: "New stream"
      page.evaluate_script("document.forms[0].submit()")

      visit streams_path
      click_link "My streams"
      click_link "New stream"
      page.should have_content item.name
    end
  end

  describe "create item in source" do

    it "should be copied to the target", js: true do
      create_fork
      sign_out user

      sign_in creator
      visit stream_path(source)
      click_link "New item"
      new_item = {}
      within("#new_item") do
        new_item = fill_in_item
        click_button "Create Item"
      end
      sign_out creator

      sign_in user
      visit stream_path(target)
      page.should have_content(new_item[:name])
    end
  end
end
