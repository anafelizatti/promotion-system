class AddStatusToProductCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :product_categories, :status, :integer
  end
end
