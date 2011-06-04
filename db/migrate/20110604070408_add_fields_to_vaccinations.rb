class AddFieldsToVaccinations < ActiveRecord::Migration
  def self.up
    add_column :vaccinations, :series, :string
    add_column :vaccinations, :least, :integer
    add_column :vaccinations, :nip, :string
    add_column :vaccinations, :injection_type, :string
  end

  def self.down
  end
end
