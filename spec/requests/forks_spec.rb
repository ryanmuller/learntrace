require 'spec_helper'

describe "Forks" do
  let!(:creator) { FactoryGirl.create(:user, name: "Course creator") }
  let!(:user) { FactoryGirl.create(:user, name: "Learner" ) }
  let!(:source) { FactoryGirl.create(:stream, user: creator) }
  let!(:item) { FactoryGirl.create(:item) }
  let!(:target) { FactoryGirl.create(:stream, user: user) }

  before { creator.pin!(item, source) }

  describe "create fork" do

    it "should create a fork and copy the items" do
      sign_in user
      visit stream_path(source)
      click_button "Create flow"
      page.should have_content target.name
      page.should have_content item.name
    end
  end
end
