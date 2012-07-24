require 'spec_helper'

describe 'Streams' do
  let!(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "create stream" do

    it "should create a stream" do
      visit streams_path
      fill_in "stream_name", :with => "New stream"
      click_button "Create"
      page.should have_content "New stream"
    end
  end

  describe "delete stream" do
    let(:stream) { FactoryGirl.create(:stream, user: user) }

    it "should remove the stream" do
      visit stream_path(stream)
      click_button "Delete this stream"
      visit streams_path
      page.should_not have_content stream.name
    end
  end

  describe "show stream" do
    let!(:stream) { FactoryGirl.create(:stream, user: user) }
    let!(:due_today_pin) { FactoryGirl.create(:due_today_pin, user: user, stream: stream) }
    let!(:due_earlier_pin) { FactoryGirl.create(:due_earlier_pin, user: user, stream: stream) }
    let!(:due_tomorrow_pin) { FactoryGirl.create(:due_tomorrow_pin, user: user, stream: stream) }
    let!(:completed_pin) { FactoryGirl.create(:completed_pin, user: user, stream: stream) }
    let!(:completed_today_pin) { FactoryGirl.create(:completed_today_pin, user: user, stream: stream) }
    
    it "should be accessible from the streams page" do
      visit streams_path
      click_link stream.name
      page.should have_content stream.name
    end

    it "should show the items due today" do
      visit stream_path(stream)
      page.should have_content due_today_pin.item.name
    end

    it "should show the items due before today" do
      visit stream_path(stream)
      page.should have_content due_earlier_pin.item.name
    end

    it "should show the items completed today" do
      visit stream_path(stream)
      page.should have_css('.completed', :text => completed_today_pin.item.name)
    end

    it "should allow items to be unpinned", js: true do
      visit stream_path(stream)
      click_link due_today_pin.item.name 
      click_link "Remove"

      page.driver.browser.switch_to.alert.accept
      page.should_not have_content(due_today_pin.item.name)
    end

    it "should allow items to be marked completed", js: true do
      visit stream_path(stream)
      click_link due_today_pin.item.name
      click_link "Complete!"

      # instantly mark complete
      page.should have_css(".item-task.completed[data-id=\"#{due_today_pin.id}\"]")

      # move on to the next item
      within("#item-name") do
        page.should have_content(due_tomorrow_pin.item.name)
      end

      # persist on revisit
      visit stream_path(stream)
      page.should have_css(".item-task.completed[data-id=\"#{due_today_pin.id}\"]")
    end

    it "should allow items to be added", js: true do
      new_item_attributes = FactoryGirl.attributes_for(:item)

      visit stream_path(stream)
      within("#new_item") do
        fill_in "Name", with: new_item_attributes[:name]
        fill_in "Description", with: new_item_attributes[:description]
        fill_in "Url", with: new_item_attributes[:url]
        click_button "Save item"
      end

      within("#stream-pins") do
        page.should have_content(new_item_attributes[:name])
      end
    end
  end
end
