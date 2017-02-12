require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    #expect(beer1.average_rating).to eq(15.0)
  end
  it "shows the ratings and rating count" do
    beers =[beer1, beer2]
    scores=10
    beers.each do |beer|
      FactoryGirl.create(:rating, score:scores+=1,  beer:beer, user:user)
    end
    visit ratings_path
    expect(page).to have_content "#{beers.count} ratings"
    beers.each do |beer|
      expect(page).to have_content beer.name
    end

  end
  it "gets deleted from the database" do
    rating=FactoryGirl.create(:rating, score:15, user:user, beer:beer1)
    FactoryGirl.create(:rating, score:10, user:user, beer:beer2)
    id=rating.id
    expect(rating).to eq(user.ratings.first)
    visit user_path(user)
    within('li', :text => 'iso 3') do
      click_on('delete')
    end
    save_and_open_page
    expect(rating).not_to eq(user.ratings.first)

  end
end
