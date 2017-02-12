require 'rails_helper'

RSpec.describe User, type: :model do

  it "has the username set correctly" do
    user = User.new username:"Pekka"
    user.username.should == "Pekka"
  end
  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved without a proper password" do
    user=User.create username:"Pekka", password:"sala", password_confirmation:"sala"
    expect(user.valid?).to be(false)
    expect(User.count).to be(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end
    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end
  describe "other favorites" do
    let(:user){FactoryGirl.create(:user)}
    it "has a favorite style" do
      beer=FactoryGirl.create(:beer, style:"IPA")
      beer3=FactoryGirl.create(:beer, style:"Lager")
      beer2=FactoryGirl.create(:beer, style:"IPA")
      rating=FactoryGirl.create(:rating, score:10, beer:beer, user:user)
      rating1=FactoryGirl.create(:rating, score:12, beer:beer2, user:user)
      rating2=FactoryGirl.create(:rating, score:20, beer:beer3, user:user)
      expect(user.favorite_style).to eq(beer3.style)
    end
  end
  describe "with a proper password" do
    let(:user){ FactoryGirl.create( :user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create( :rating)
      user.ratings << FactoryGirl.create( :rating2)

      expect(user.ratings.count).to eq(2)
      #expect(user.average_rating).to eq(15)
    end

  end
    def create_beer_with_rating(user, score)
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end
def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating(user, score)
  end
end
end
