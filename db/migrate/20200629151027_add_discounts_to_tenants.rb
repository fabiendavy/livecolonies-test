class AddDiscountsToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :discount, :integer
    add_column :tenants, :start_date_discount, :date
    add_column :tenants, :end_date_discount, :date
  end
end
