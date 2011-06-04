class CreateInoculationLogs < ActiveRecord::Migration
  def self.up
    create_table :inoculation_logs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :inoculation_logs
  end
end
