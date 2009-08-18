class CreateMemberinfo < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `memberinfo` (
      `member_id` int(11) NOT NULL default '0',
      `data_key` varchar(100) NOT NULL default '',
      `data_value` text NOT NULL,
      `lastupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
      UNIQUE KEY `memberinfo_member_id_data_key` (`member_id`,`data_key`),
      KEY `member_id` (`member_id`)
    );
    EOF
  end

  def self.down
    drop_table :memberinfo
  end
end
