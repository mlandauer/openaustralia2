require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'hpricot'
require 'open-uri'

# Before running these test need to make sure that the original openaustralia php code has its
# database configuration pointing to the oa_test database (which gets loaded with fixtures data here).

describe "MembersController" do
  fixtures :member

  it "should render the representatives page exactly the same as the php version" do
    puts Hpricot(open("http://dev.openaustralia.org/mps"))
  end
end
