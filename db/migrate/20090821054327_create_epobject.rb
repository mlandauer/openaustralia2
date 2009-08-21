class CreateEpobject < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `epobject` (
      `epobject_id` int(11) NOT NULL auto_increment,
      `title` varchar(255) default NULL,
      `body` mediumtext,
      `type` int(11) default NULL,
      `created` datetime default NULL,
      `modified` datetime default NULL,
      PRIMARY KEY  (`epobject_id`),
      KEY `type` (`type`)
    );
    EOF
  end

  def self.down
    drop_table :epobject
  end
end
