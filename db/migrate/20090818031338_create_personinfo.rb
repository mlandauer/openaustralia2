class CreatePersoninfo < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `personinfo` (
      `person_id` int(11) NOT NULL default '0',
      `data_key` varchar(100) NOT NULL default '',
      `data_value` text NOT NULL,
      `lastupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
      UNIQUE KEY `personinfo_person_id_data_key` (`person_id`,`data_key`),
      KEY `person_id` (`person_id`)
    );
    EOF
  end

  def self.down
    drop_table :personinfo
  end
end
