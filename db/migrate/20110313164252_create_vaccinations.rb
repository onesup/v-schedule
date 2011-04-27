class CreateVaccinations < ActiveRecord::Migration
  def self.up
    create_table :vaccinations do |t|
      t.string :title
      t.text :desc
      t.integer :timing
      t.string :contury

      t.timestamps
    end
  end

  def self.down
    drop_table :vaccinations
  end
end
