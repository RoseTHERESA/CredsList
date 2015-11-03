require 'rails_helper'

feature 'R in CRUD: reading items' do

  scenario 'Accessing items while not logged in' do
    visit home_path
    expect(page.current_path).to eq home_path
  end

  scenario 'Accessing items while logged in' do
    login_user
    visit home_path
    expect(page.current_path).to eq home_path
  end

end

feature 'C in CRUD: creating items' do

  scenario 'Trying to create items while not logged in' do
    visit new_item_path
    expect(page.current_path).to eq root_path
    expect(page).to have_content 'Please log in'
  end

  scenario 'Creating item while logged in ' do
    login_user
    visit new_item_path
    within '#create' do
      fill_in 'Name', with: 'Item1'
      fill_in 'Picture URL', with: 'Item1.jpg'
      fill_in 'Descrption', with: 'First item'
      fill_in 'Price', with: 9.99
    end
    click_button 'Create Item'
    expect(page.current_path).to eq root_path
    expect(page).to have_content 'Item1'
  end

end

feature 'U in CRUD: updating items' do

end

feature 'D in CRUD: deleting items' do

end

def login_user
  @user = User.create(email: 'user1@test.com', password: 'user1')
  visit root_path
  within '#login' do
    fill_in 'Username', with: @user.email
    fill_in 'Password', with: @user.password
  end
  click_button 'Login'
end