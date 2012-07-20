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
end
