require 'spec_helper'
require_relative '../../app/hero_app'
Capybara.app = HeroApp

feature "User" do

  before do
    DB[:users].delete
    User.new(DB)
  end
  scenario "User can create an account and Admin can View it" do
    visit "/"
    expect(page).to have_content("Defense of the Ancients Draft")
    expect(page).to have_no_content("Welcome, admin!")
    expect(page).to have_no_content("Log Out")

    click_on("Create Account")
    expect(page).to have_content("Create New Account")
    fill_in "username", with: "testuser"
    fill_in "first_name", with: "first name"
    fill_in "last_name", with: "last name"
    fill_in "email", with: "email@email.com"
    click_on("Create Account")
    expect(page).to have_no_content("Create New Account")
    expect(page).to have_content("Defense of the Ancients Draft")
    click_on "Log In"
    fill_in "Secret Password", with: "password"
    click_on "Login"
    click_on "All Users"
    expect(page).to have_content("testuser")
    click_on("testuser")
    expect(page).to have_content("first name")
    expect(page).to have_content("last name")
    expect(page).to have_content("email@email.com")


  end



end