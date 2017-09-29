require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require('pry')

get('/') do
  @stores = Store.all()
  @brands = Brand.all()
  erb(:index)
end

get('/add_store') do
  @stores = Store.all()
  erb(:add_store)
end

get("/store/:id") do
  @store = Store.find(params["id"])
  @brands = Brand.all()
  erb(:store)
end

get('/brand_error') do

end

post('/create_store') do
  title = params['title']
  location = params['location']
  @store = Store.new({:title => title, :location => location})
  if @store.save()
    redirect('/add_store')
  else
    erb(:store_error)
  end
end

post("/store/:id") do
  @brands = Brand.all()
  @store = Store.find(params["id"])
  title = params['brands']
  @brand = Brand.new({:title => title})
  if @brand.save()
    @store.brands.push(new_brand)
    erb(:store)
  else
    erb(:brand_error)
  end
end

delete("/delete_store") do
  store_ids = params.fetch('store_ids')
  store_ids.each do |i|
    Store.find(i).delete()
  end
  redirect('/add_store')
end
