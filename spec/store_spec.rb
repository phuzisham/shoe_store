require('spec_helper')

describe(Store) do
  it { should have_and_belong_to_many(:brands) }

  it("ensures the length of title is at most 100 characters") do
    store = Store.new({:title => "a".*(101)})
    expect(store.save()).to(eq(false))
  end

  it("ensures that title doesn't already exist") do
    Store.create({:title => 'Jim\'s Shoes'})
    store = Store.new({:title => 'Jim\'s Shoes'})
    expect(store.save()).to(eq(false))
  end

  it('will capitalize title') do
    store = Store.create({:title => 'croc larkins'})
    expect(store.title).to(eq('Croc Larkins'))
  end
end
