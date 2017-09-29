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

describe('adding a new brand', {:type => :feature}) do
  it('allows a user to add a brand') do
    visit('/')
    click_link('Add or Delete a shoe brand!')
    fill_in('title', :with => 'Croc Larkins')
    fill_in('price', :with => '40')
    click_button('Add Brand')
    expect(page).to have_content('Croc Larkins')
  end
end

describe('deleting a store', {:type => :feature}) do
  it('allows a user to delete a store') do
    Store.create(:title => 'Croc Larkins')
    visit('/')
    click_link('Croc Larkins')
    click_button('Delete Store')
    expect(page).not_to have_content('Croc Larkins')
  end
end

describe('deleting a brand', {:type => :feature}) do
  it('allows a user to delete a brand') do
    brand = Brand.create(:title => 'Croc Larkins', :price => '40')
    visit('/')
    click_link('Add or Delete a shoe brand!')
    find(:css, "#brandID[value='#{brand.id}']").set(true)
    click_button('Delete Selected Brands')
    expect(page).not_to have_content('Croc Larkins')
  end
end

describe('searching for a store', {:type => :feature}) do
  it('allows a user to search for a store') do
    Store.create(:title => 'Croc Larkins', :location => 'Hillsboro')
    visit('/')
    fill_in('search', :with => 'Croc Larkins')
    click_button('Search')
    expect(page).to have_content('Location: Hillsboro')
  end
end
