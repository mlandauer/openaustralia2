class CreateTitles < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `titles` (
      `title` varchar(190) NOT NULL default '',
      PRIMARY KEY  (`title`)
    );
    EOF
  end

  def self.down
    drop_table :titles
  end
end
