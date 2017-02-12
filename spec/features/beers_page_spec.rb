require 'rails_helper'

describe "beer" do
let!(:brewery) { FactoryGirl.create :brewery, name:"Weihenstephaner" }
  it "needs a name" do
    visit new_beer_path
    select('IPA', from:'beer[style]')
    select('Weihenstephaner', from:'beer[brewery_id]')
    click_button('Create Beer')
    #expect(current_path).to eq(new_beer_path)
    expect(brewery.beers.count).to eq(0)

  end


end
