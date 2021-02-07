class AddReceptorUserIdToPromotions < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :receptor_user_id, :integer
  end
end
