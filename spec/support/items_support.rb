module CreateItemHelper
  def fill_in_item
    new_item_attributes = FactoryGirl.attributes_for(:item)
    fill_in "Name", with: new_item_attributes[:name]
    fill_in "Description", with: new_item_attributes[:description]
    fill_in "Url", with: new_item_attributes[:url]
    return new_item_attributes
  end
end

RSpec.configure do |config|
  config.include CreateItemHelper, type: :request
end

