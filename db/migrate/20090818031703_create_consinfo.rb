class CreateConsinfo < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `consinfo` (
      `constituency` varchar(100) NOT NULL default '',
      `data_key` varchar(100) NOT NULL default '',
      `data_value` text NOT NULL,
      UNIQUE KEY `consinfo_constituency_data_key` (`constituency`,`data_key`),
      KEY `constituency` (`constituency`)
    );
    EOF
  end

  def self.down
    drop_table :consinfo
  end
end
