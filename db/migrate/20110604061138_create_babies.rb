class CreateBabies < ActiveRecord::Migration
  def self.up
    create_table :babies do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :babies
  end
end
