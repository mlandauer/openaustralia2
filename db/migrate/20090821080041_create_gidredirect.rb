class CreateGidredirect < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `gidredirect` (
      `gid_from` char(60) default NULL,
      `gid_to` char(60) default NULL,
      `hdate` date NOT NULL default '0000-00-00',
      `major` int(11) default NULL,
      UNIQUE KEY `gid_from` (`gid_from`),
      KEY `gid_to` (`gid_to`)
    );
    EOF
  end

  def self.down
    drop_table :gidredirect
  end
end
