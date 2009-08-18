class CreateAlerts < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `alerts` (
      `alert_id` mediumint(8) unsigned NOT NULL auto_increment,
      `email` varchar(255) NOT NULL default '',
      `criteria` varchar(255) NOT NULL default '',
      `deleted` tinyint(1) NOT NULL default '0',
      `registrationtoken` varchar(34) NOT NULL default '',
      `confirmed` tinyint(1) NOT NULL default '0',
      `created` datetime NOT NULL default '0000-00-00 00:00:00',
      PRIMARY KEY  (`alert_id`),
      KEY `email` (`email`),
      KEY `confirmed` (`confirmed`,`deleted`)
    );
    EOF
  end

  def self.down
    drop_table :alerts
  end
end
