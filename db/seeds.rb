# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tenant.destroy_all
Studio.destroy_all
Stay.destroy_all

tenant_ids = []
studio_ids = []

for i in 1..10 do
  tenant = Tenant.new(email: "example#{i}@test.com")
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

Tenant.all.each do |tenant|
  new_stay = Stay.new(
    start_date: Date.today,
    end_date: Date.today.next_month(rand(1..5)),
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
puts "10 Stays created."
