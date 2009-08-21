class CreateHansard < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `hansard` (
      `epobject_id` int(11) NOT NULL default '0',
      `gid` varchar(100) default NULL,
      `htype` int(11) NOT NULL default '0',
      `speaker_id` int(11) NOT NULL default '0',
      `major` int(11) NOT NULL default '0',
      `section_id` int(11) NOT NULL default '0',
      `subsection_id` int(11) NOT NULL default '0',
      `hpos` int(11) NOT NULL default '0',
      `hdate` date NOT NULL default '0000-00-00',
      `htime` time default NULL,
      `source_url` varchar(255) NOT NULL default '',
      `minor` int(11) default NULL,
      `created` datetime default NULL,
      `modified` datetime default NULL,
      PRIMARY KEY  (`epobject_id`),
      UNIQUE KEY `gid` (`gid`),
      KEY `epobject_id` (`epobject_id`),
      KEY `subsection_id` (`subsection_id`),
      KEY `section_id` (`section_id`),
      KEY `hdate` (`hdate`),
      KEY `speaker_id` (`speaker_id`),
      KEY `hansard_speaker_id_hdate_hpos` (`speaker_id`,`hdate`,`hpos`),
      KEY `major` (`major`),
      KEY `htype` (`htype`),
      KEY `majorhdate` (`major`,`hdate`),
      KEY `modified` (`modified`),
      KEY `source_url` (`source_url`)
    );
    EOF
  end

  def self.down
    drop_table :hansard
  end
end
