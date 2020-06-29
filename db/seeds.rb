Tenant.destroy_all
Studio.destroy_all
Stay.destroy_all

tenant_ids = []
studio_ids = []

10.times do
  tenant = Tenant.new(email: "#{Faker::Name.name.gsub('.', '').split(' ').join('.').downcase}@test.com")
  tenant.save
  tenant_ids << tenant.id
end
puts "10 tenants created."

5.times do
  studio = Studio.new(name: Faker::Address.street_name, monthly_price: rand(500..1000))
  studio.save
  studio_ids << studio.id
end
puts "5 studios created."

date = Date.new(2020, 1, 15)
Tenant.all.each do |tenant|
  new_stay = Stay.new(
    start_date: date,
    end_date: date.next_month(rand(1..5)),
    tenant_id: tenant.id,
    studio_id: studio_ids.sample
  )
  prev_stay = Stay.where(studio: new_stay.studio).last
  if prev_stay
    new_stay.start_date = prev_stay.end_date + 1
    new_stay.end_date = new_stay.start_date.next_month(rand(1..5))
    p new_stay.errors.messages unless new_stay.save
  end
  new_stay.save
end
puts "10 stays created."

Tenant.first(5).each do |tenant|
  tenant.discount = [20, 25, 30, 35, 40].sample
  tenant.start_date_discount = tenant.stays.first.start_date
  tenant.end_date_discount = tenant.start_date_discount + rand(20..40)
  tenant.save
end
puts "5 first tenant's discount created."
