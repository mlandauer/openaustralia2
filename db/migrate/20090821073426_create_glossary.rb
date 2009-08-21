class CreateGlossary < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `glossary` (
      `glossary_id` int(11) NOT NULL auto_increment,
      `title` varchar(255) default NULL,
      `body` text,
      `wikipedia` varchar(255) default NULL,
      `created` datetime default NULL,
      `last_modified` datetime default NULL,
      `type` int(2) default NULL,
      `visible` tinyint(4) default NULL,
      PRIMARY KEY  (`glossary_id`),
      KEY `visible` (`visible`)
    );
    EOF
  end

  def self.down
    drop_table :glossary
  end
end
