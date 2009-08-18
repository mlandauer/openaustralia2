class CreateBills < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `bills` (
      `id` int(11) NOT NULL auto_increment,
      `title` varchar(255) NOT NULL default '',
      `url` varchar(255) NOT NULL default '',
      `lords` tinyint(1) NOT NULL default '0',
      `session` varchar(50) NOT NULL default '',
      `standingprefix` varchar(255) NOT NULL default '',
      PRIMARY KEY  (`id`),
      KEY `title` (`title`)
    );
    EOF
  end

  def self.down
    drop_table :bills
  end
end
