class CreateComments < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `comments` (
      `comment_id` int(11) NOT NULL auto_increment,
      `user_id` int(11) NOT NULL default '0',
      `epobject_id` int(11) NOT NULL default '0',
      `body` text,
      `posted` datetime default NULL,
      `modflagged` datetime default NULL,
      `visible` tinyint(1) NOT NULL default '0',
      `original_gid` varchar(60) default NULL,
      PRIMARY KEY  (`comment_id`),
      KEY `user_id` (`user_id`,`epobject_id`,`visible`),
      KEY `epobject_id` (`epobject_id`,`visible`),
      KEY `visible` (`visible`)
    );
    EOF
  end

  def self.down
    drop_table :comments
  end
end
