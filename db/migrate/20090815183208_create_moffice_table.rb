class CreateMofficeTable < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `moffice` (
      `moffice_id` int(11) NOT NULL auto_increment,
      `dept` varchar(100) NOT NULL default '',
      `position` varchar(200) NOT NULL default '',
      `from_date` date NOT NULL default '1000-01-01',
      `to_date` date NOT NULL default '9999-12-31',
      `person` int(11) default NULL,
      `source` varchar(255) NOT NULL default '',
      PRIMARY KEY  (`moffice_id`),
      KEY `person` (`person`)
    );
    EOF
  end

  def self.down
    drop_table :moffice
  end
end
