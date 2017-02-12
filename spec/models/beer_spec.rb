require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "gets saved correctly" do
    beer=Beer.create name:"olut", style:"IPA"

    expect(beer).to be_valid
    expect(Beer.count).to be(1)
    
  end

  it "isn't valid without a name" do
    beer=Beer.create style:"IPA"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to be(0)
  end

  it "isn't valid without a style" do
    beer=Beer.create name:"olut"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to be(0)
  end
end
