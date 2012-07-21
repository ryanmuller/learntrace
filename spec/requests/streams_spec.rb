require 'spec_helper'

describe 'Streams' do
  let!(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "create stream" do

    it "should create a stream" do
      visit streams_path
      fill_in "stream_name", :with => "New stream"
      click_button "Create stream"
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
    let!(:due_yesterday_pin) { FactoryGirl.create(:due_yesterday_pin, user: user, stream: stream) }
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
      page.should have_css('li.incomplete', :text => due_today_pin.item.name)
    end

    it "should show the items due yesterday" do
      visit stream_path(stream)
      page.should have_css('li.overdue', :text => due_yesterday_pin.item.name)
    end

    it "should show the items completed today" do
      visit stream_path(stream)
      page.should have_css('li.complete', :text => completed_today_pin.item.name)
    end

    it "should not show the items due tomorrow" do
      visit stream_path(stream)
      page.should_not have_content(due_tomorrow_pin.item.name)
    end

    it "should not show the items completed before today" do
      visit stream_path(stream)
      page.should_not have_content(completed_pin.item.name)
    end

  end
end
