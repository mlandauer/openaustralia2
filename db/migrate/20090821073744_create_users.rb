class CreateUsers < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `users` (
      `user_id` mediumint(9) NOT NULL auto_increment,
      `firstname` varchar(255) NOT NULL default '',
      `lastname` varchar(255) NOT NULL default '',
      `email` varchar(255) NOT NULL default '',
      `password` varchar(34) NOT NULL default '',
      `lastvisit` datetime NOT NULL default '0000-00-00 00:00:00',
      `registrationtime` datetime NOT NULL default '0000-00-00 00:00:00',
      `registrationip` varchar(20) default NULL,
      `status` enum('Viewer','User','Moderator','Administrator','Superuser') default 'Viewer',
      `emailpublic` tinyint(1) NOT NULL default '0',
      `optin` tinyint(1) NOT NULL default '0',
      `deleted` tinyint(1) NOT NULL default '0',
      `constituency` varchar(255) NOT NULL default '',
      `registrationtoken` varchar(24) NOT NULL default '',
      `confirmed` tinyint(1) NOT NULL default '0',
      `url` varchar(255) NOT NULL default '',
      `api_key` char(24),
      PRIMARY KEY  (`user_id`),
      UNIQUE KEY `api_key` (`api_key`),
      KEY `email` (`email`)
    );
    EOF
    # Changing the enum column to strings so that it can be correctly dumped in schema.rb
    # Should be able to set the dump format to SQL in environments/test.rb but it appears not to be working. Ugh.
    change_column :users, :status, :string, :limit => 15, :default => "Viewer"
  end

  def self.down
    drop_table :users
  end
end
