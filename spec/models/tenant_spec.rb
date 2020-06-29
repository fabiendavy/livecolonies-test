require 'rails_helper'

RSpec.describe Tenant, type: :model do

  it 'shouldn\'t be possible for two people to be in the same studio at the same time' do
    tenant1 = Tenant.create!(email: 'example1@test.com')
    tenant2 = Tenant.create!(email: 'example2@test.com')
    studio = Studio.create!(name: 'My studio', monthly_price: 850)
    stay = Stay.new(tenant: tenant1, studio: studio, start_date: Date.today, end_date: Date.today.next_month(2))
    expect(stay).to be_valid
    stay.save

    stay2 = Stay.new(tenant: tenant2, studio: studio, start_date: Date.today, end_date: Date.today.next_month(2))
    expect(stay2).not_to be_valid
  end

  it 'should be possible for two people to be in the same studio not in the same time' do
    tenant1 = Tenant.create!(email: 'example1@test.com')
    tenant2 = Tenant.create!(email: 'example2@test.com')
    studio = Studio.create!(name: 'My studio', monthly_price: 850)
    stay = Stay.new(tenant: tenant1, studio: studio, start_date: Date.today, end_date: Date.today.next_month(2))
    expect(stay).to be_valid
    stay.save

    stay2 = Stay.new(tenant: tenant2, studio: studio, start_date: Date.today.next_month(3), end_date: Date.today.next_month(4))
    expect(stay2).to be_valid
  end
end
