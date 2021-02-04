class RemoveStatusFromProductCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_categories, :status, :integer
  end
end
