class CreateSearchQueryLog < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `search_query_log` (
      `id` int(11) NOT NULL auto_increment,
      `query_string` text,
      `page_number` int(11) default NULL,
      `count_hits` int(11) default NULL,
      `ip_address` text,
      `query_time` datetime default NULL,
      PRIMARY KEY  (`id`),
      KEY `query_time` (`query_time`)
    );
    EOF
  end

  def self.down
    drop_table :search_query_log
  end
end
