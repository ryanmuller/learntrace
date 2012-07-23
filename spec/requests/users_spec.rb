require 'spec_helper'

describe 'Users' do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let!(:stream) { FactoryGirl.create(:stream, user: other_user) }

  before { sign_in user }

  describe "view another user" do
    it "should show the user and their streams" do
      visit user_path(other_user)
      page.should have_content other_user.name
      page.should have_content stream.name
    end
  end
end
