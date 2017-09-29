class CreateStoresAndBrands < ActiveRecord::Migration[5.1]
  def change
    def change
      create_table(:stores) do |t|
        t.column(:title, :string)
        t.column(:location, :string)
        t.timestamps()
      end
      create_table(:brands) do |t|
        t.column(:title, :string)
        t.column(:price, :decimal, precision: 5, scale: 2)
        t.timestamps()
      end
    end
  end
end
