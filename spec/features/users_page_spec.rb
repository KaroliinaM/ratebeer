require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
      it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
    it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
    end
    it "shows ratings on users page" do
      user1=FactoryGirl.create :user, username:"Janne"
      user2=FactoryGirl.create :user, username:"janne2"
      brewery=FactoryGirl.create :brewery
      beer1=FactoryGirl.create :beer, name:"Olut", brewery:brewery 
      beer2=FactoryGirl.create :beer, name:"kolmonen", brewery:brewery
      beer3=FactoryGirl.create :beer, name:"nelonen", brewery:brewery 
      reittaus=FactoryGirl.create :rating, score:12, beer:beer1, user:user1
      toinen_reittaus=FactoryGirl.create :rating, score:13, beer:beer1, user:user2
      kolmas_reittaus=FactoryGirl.create :rating, score:11, beer:beer2, user:user1
      visit user_path(user1)
      save_and_open_page
      expect(page).to have_content "#{user1.ratings.first.beer.name} #{user1.ratings.first.score}"
      expect(page).to have_no_content "#{user2.ratings.first.beer.name} #{user2.ratings.first.score}"
      
    end
  end
end
