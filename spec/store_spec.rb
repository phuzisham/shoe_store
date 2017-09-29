require('spec_helper')

describe(Store) do
  it { should have_and_belong_to_many(:brands) }
  # it("ensures the length of title is at most 40 characters") do
  #   store = Store.new({:title => "a".*(41)})
  #   expect(store.save()).to(eq(false))
  # end
  # it("ensures that title doesn't already exist") do
  #   store.create({:title => 'Jim\'s Shoes'})
  #   store = Store.new({:title => 'Jim\'s Shoes'})
  #   expect(store.save()).to(eq(false))
  # end
end
