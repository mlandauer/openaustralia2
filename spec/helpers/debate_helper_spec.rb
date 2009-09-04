require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DebateHelper do
  it "should render a cute little calendar for the month" do
    # Calendar for January 2009
    b = Builder::XmlMarkup.new
    helper.calendar(2009, 1).should == b.table do
      b.caption 'January 2009'
      b.thead do
        b.tr do
          b.th "Mon"
          b.th "Tue"
          b.th "Wed"
          b.th "Thu"
          b.th "Fri"
          b.th "Sat"
          b.th "Sun"
        end
      end
      b.tbody do
        b.tr do
          b.td({:colspan => "3"}, "&nbsp;")
          (1..4).each {|day| b.td day}
        end
        b.tr do
          (5..11).each {|day| b.td day}
        end
        b.tr do
          (12..18).each {|day| b.td day}
        end
        b.tr do
          (19..25).each {|day| b.td day}
        end
        b.tr do
          (26..31).each {|day| b.td day}
        end
      end
    end
  end
end
