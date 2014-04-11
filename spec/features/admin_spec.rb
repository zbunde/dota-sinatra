require 'spec_helper'
require_relative '../../app/hero_app'
Capybara.app = HeroApp

feature "Admin" do
  before do
    DB[:heroes].delete
    HeroRepository.new(DB)
  end

  scenario "admin can log in and lot out" do
    visit "/"
    expect(page).to have_content("Defense of the Ancients Draft")
    expect(page).to have_no_content("Welcome, admin!")
    expect(page).to have_no_content("Log Out")

    click_on "Log In"

    fill_in "Secret Password", with: "whatever"
    click_on "Login"
    expect(page).to have_content("Incorrect Password")

    fill_in "Secret Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Welcome, admin!")
    expect(page).to have_no_content("Log In")

    click_on "Log Out"
    expect(page).to have_no_content("Welcome, admin!")
    expect(page).to have_content("Defense of the Ancients Draft")
  end

  scenario "Admin can add a hero" do
    visit "/"
    expect(page).to have_content("Defense of the Ancients Draft")
    expect(page).to have_no_content("Welcome, admin!")
    expect(page).to have_no_content("Log Out")

    click_on "Log In"

    fill_in "Secret Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Welcome, admin!")
    expect(page).to have_no_content("Log In")


    click_on "Add Hero"
    expect(page).to have_content("Add a Hero")
    fill_in "name", with: "zoggert"
    fill_in "description", with: "lives in a cave"
    select("Carry", from: "hero_type")
    attach_file("Image", "/Users/zbunde/dota2/hero_images/axe.png")
    click_on "Create"

    expect(page).to have_no_content("Add a Hero")
    expect(page).to have_content("All Heroes")
    expect(page).to have_content("zoggert")
  end

  scenario "Users can see a show page for every hero" do

    visit "/"

    click_on "Log In"

    fill_in "Secret Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Welcome, admin!")
    expect(page).to have_no_content("Log In")


    click_on "Add Hero"
    expect(page).to have_content("Add a Hero")
    fill_in "name", with: "zoggert"
    fill_in "description", with: "lives in a cave"
    select("Carry", from: "hero_type")
    attach_file("Image", "/Users/zbunde/dota2/hero_images/axe.png")
    click_on "Create"
    visit "/"
    click_on "All Heroes"
    click_on "zoggert"
    expect(page).to have_content "zoggert"
    expect(page).to have_content "lives in a cave"
    expect(page).to have_content "Carry"

  end

  scenario "Admin can update heroes" do
    DB[:heroes].insert(:name => "hello", :description => "wtf", :hero_type => "Carry", :image => "cool")
    DB[:heroes].insert(:name => "yoyo", :description => "yoyo", :hero_type => "Carry", :image => "cool")

    visit "/"
    click_on "Log In"
    fill_in "Secret Password", with: "password"
    click_on "Login"
    click_on "All Heroes"
    click_on "hello"
    click_on "Edit"
    expect(page).to have_content "Edit hello"
    fill_in "name", with: "whatever"
    fill_in "description", with: "food"
    select("Carry", from: "hero_type")
    attach_file("Image", "/Users/zbunde/dota2/hero_images/axe.png")
    click_on "Edit"
    expect(page).to have_content "whatever"
    click_on "whatever"
    expect(page).to have_content "food"


  end

  scenario "Admin can Delete a Hero" do
    DB[:heroes].insert(:name => "hello", :description => "wtf", :hero_type => "Carry", :image => "cool")
    visit "/"
    click_on "Log In"
    fill_in "Secret Password", with: "password"
    click_on "Login"
    click_on "All Heroes"
    click_on "hello"
    click_on "delete"
    expect(page).to have_no_content "hello"

  end


end
