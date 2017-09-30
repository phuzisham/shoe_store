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

get('/add_brand') do
  @brands = Brand.all()
  erb(:add_brand)
end

get("/store/:id") do
  @store = Store.find(params["id"])
  @brands = Brand.all()
  erb(:store)
end

get("/brand/:id") do
  @brand = Brand.find(params["id"])
  erb(:brand)
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

post('/create_brand') do
  title = params['title']
  price = params['price']
  @brand = Brand.new({:title => title, :price => price})
  if @brand.save()
    redirect('/add_brand')
  else
    erb(:brand_error)
  end
end

post("/store/:id") do
  @brands = Brand.all()
  @store = Store.find(params["id"])
  title = params['brands']
  price = params['price']
  @brand = Brand.new({:title => title, :price => price})
  if @brand.save()
    @store.brands.push(@brand)
    erb(:store)
  else
    erb(:brand_error)
  end
end

post("/search_store") do
  search_query = params['search']
  @store = Store.where("title ILIKE (?)", "%#{search_query}%").first
  if @store
    id = @store.id
    redirect("/store/#{id}")
  else
    erb(:search_fail)
  end
end

patch('/store_location/:id') do
  @brands = Brand.all()
  @store = Store.find(params["id"])
  location = params['location']
  @store.update({:location => location})
  erb(:store)
end

patch('/store_title/:id') do
  @brands = Brand.all()
  @store = Store.find(params["id"])
  title = params['title']
  @store.update({:title => title})
  erb(:store)
end

patch('/add_brand/:id') do
  @store = Store.find(params['id'])
  if params.has_key?('brand_ids')
    params.fetch('brand_ids').each do |i|
      brand = Brand.find(i)
      @store.brands.push(brand)
      redirect("/store/#{@store.id}")
    end
    else
      erb(:search_fail)
  end
end

delete("/delete_store") do
  store_ids = params.fetch('store_ids')
  store_ids.each do |i|
    Store.find(i).delete()
  end
  redirect('/add_store')
end

delete("/delete_brand") do
  brand_ids = params.fetch('brand_ids')
  brand_ids.each do |i|
    Brand.find(i).delete()
  end
  redirect('/add_brand')
end

delete("/store/:id") do
  @store = Store.find(params["id"])
  @store.delete
  redirect "/"
end
