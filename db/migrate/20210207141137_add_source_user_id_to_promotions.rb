class AddSourceUserIdToPromotions < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :source_user_id, :integer
  end
end
