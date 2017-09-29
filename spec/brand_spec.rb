require('spec_helper')

describe(Brand) do
  it { should have_and_belong_to_many(:stores) }
  it("ensures the length of title is at most 40 characters") do
    brand = Brand.new({:title => "a".*(41)})
    expect(brand.save()).to(eq(false))
  end
  it("ensures that title doesn't already exist") do
    Brand.create({:title => 'Croc Larkins'})
    brand = Brand.new({:title => 'Croc Larkins'})
    expect(brand.save()).to(eq(false))
  end
end
