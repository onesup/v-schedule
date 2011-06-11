class CreateBabies < ActiveRecord::Migration
  def self.up
    create_table :babies do |t|
      
      t.datetime :born_at 

      t.timestamps
    end
  end

  def self.down
    drop_table :babies
  end
end
