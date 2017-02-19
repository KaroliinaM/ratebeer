require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return( [
Place.new(name:"Oljenkorsi", id:1)])
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "All returned are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return( [
Place.new(name:"Oljenkorsi", id:1), Place.new(name:"Kumpulan baari", id:2), Place.new(name:"Hiivaisten päämaja", id:3)])
   visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    save_and_open_page

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Hiivaisten"
    expect(page).to have_content "Kumpulan baari"
  
  end
  it "Has the correct text if none are found" do
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end

  
