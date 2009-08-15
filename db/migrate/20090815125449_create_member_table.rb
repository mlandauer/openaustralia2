class CreateMemberTable < ActiveRecord::Migration
  def self.up
    execute <<-EOF
    CREATE TABLE `member` (
      `member_id` int(11) NOT NULL default '0',
      `house` int(11) default NULL,
      `first_name` varchar(100) default NULL,
      `last_name` varchar(255) NOT NULL default '',
      `constituency` varchar(100) NOT NULL default '',
      `party` varchar(100) NOT NULL default '',
      `entered_house` date NOT NULL default '1000-01-01',
      `left_house` date NOT NULL default '9999-12-31',
      `entered_reason` enum('unknown','general_election','by_election','changed_party','reinstated','appointed','devolution','election','accession','regional_election','replaced_in_region','became_presiding_officer') NOT NULL default 'unknown',
      `left_reason` enum('unknown','still_in_office','general_election','general_election_standing','general_election_not_standing','changed_party','died','declared_void','resigned','disqualified','became_peer','devolution','dissolution','retired','regional_election','became_presiding_officer') NOT NULL default 'unknown',
      `person_id` int(11) NOT NULL default '0',
      `title` varchar(50) NOT NULL default '',
      `lastupdate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
      PRIMARY KEY  (`member_id`),
      UNIQUE KEY `first_name` (`first_name`,`last_name`,`constituency`,`entered_house`,`left_house`),
      KEY `person_id` (`person_id`),
      KEY `constituency` (`constituency`),
      KEY `house` (`house`),
      KEY `left_house_house` (`left_house`,`house`)
    );
    EOF
    # Changing the enum columns to strings so that they can be correctly dumped in schema.rb
    change_column :member, :entered_reason, :string, :limit => 30, :null => false, :default => "unknown"
    change_column :member, :left_reason, :string, :limit => 30, :null => false, :default => "unknown"
  end

  def self.down
    drop_table :member
  end
end
