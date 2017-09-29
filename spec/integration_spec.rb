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

describe('update a store', {:type => :feature}) do
  it('allows a user to update a store title') do
    store = Store.create(:title => 'Croc Larkins')
    visit('/')
    click_link('Croc Larkins')
    fill_in('title', :with => 'Jim\'s Cobblery')
    click_button('Update Store')
    expect(page).to have_content('Jim\'s Cobblery')
  end

  it('allows a user to update a store location') do
    store = Store.create(:title => 'Croc Larkins')
    store.update(:location => 'Hillsboro')
    visit('/')
    click_link('Croc Larkins')
    fill_in('location', :with => 'Hillsboro')
    click_button('Update Location')
    expect(page).to have_content('Hillsboro')
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

describe('clicking a brand') do
  it('will display stores that carry tha brand') do
    store1 = Store.create(:title => 'Croc Larkins', :location => 'Hillsboro')
    store2 = Store.create(:title => 'The Cobbler\'s', :location => 'Beaverton')
    brand = Brand.create(:title => 'Croc Larkins', :price => '40')
    store1.brands.push(brand)
    store2.brands.push(brand)
    expect(brand.stores).to(eq([store1, store2]))
  end
end
