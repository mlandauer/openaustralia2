class CreateEditqueue < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `editqueue` (
      `edit_id` int(11) NOT NULL auto_increment,
      `user_id` int(11) default NULL,
      `edit_type` int(11) default NULL,
      `epobject_id_l` int(11) default NULL,
      `epobject_id_h` int(11) default NULL,
      `glossary_id` int(11) default NULL,
      `time_start` datetime default NULL,
      `time_end` datetime default NULL,
      `title` varchar(255) default NULL,
      `body` text,
      `submitted` datetime default NULL,
      `editor_id` int(11) default NULL,
      `approved` tinyint(1) default NULL,
      `decided` datetime default NULL,
      `reason` varchar(255) default NULL,
      PRIMARY KEY  (`edit_id`),
      KEY `approved` (`approved`),
      KEY `glossary_id` (`glossary_id`)
    );
    EOF
  end

  def self.down
    drop_table :edit_queue
  end
end
