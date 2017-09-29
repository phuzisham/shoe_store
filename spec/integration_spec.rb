require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new store', {:type => :feature}) do
  it('allows a user to add a store') do
    visit('/')
    click_link('Add or Delete a store!')
    fill_in('title', :with => 'Jim\'s Shoes')
    click_button('Add Store')
    expect(page).to have_content('Jim\'s Shoes')
  end
end

describe('adding a new store', {:type => :feature}) do
  it('allows a user to add a store') do
    visit('/')
    click_link('Add or Delete a shoe brand!')
    fill_in('title', :with => 'Croc Larkins')
    click_button('Add Brand')
    expect(page).to have_content('Croc Larkins')
  end
end
