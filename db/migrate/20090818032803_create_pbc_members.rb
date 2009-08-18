class CreatePbcMembers < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `pbc_members` (
      `id` int(11) NOT NULL auto_increment,
      `member_id` int(11) NOT NULL default '0',
      `chairman` tinyint(1) NOT NULL default '0',
      `bill_id` int(11) NOT NULL default '0',
      `sitting` varchar(4) NOT NULL default '',
      `attending` tinyint(1) NOT NULL default '0',
      PRIMARY KEY  (`id`),
      KEY `member_id` (`member_id`),
      KEY `bill_id` (`bill_id`)
    );
    EOF
  end

  def self.down
    drop_table :pbc_members
  end
end
