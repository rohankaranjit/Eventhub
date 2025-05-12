class AddPriceToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :price, :integer
  end
end
