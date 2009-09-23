require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DebateHelper do
  it "should render a cute little calendar for the month" do
    # Calendar for January 2009
    expected = ""
    b = Builder::XmlMarkup.new(:target => expected)
    # Dates in recess
    recess = [(Date.new(2009,1,1)..Date.new(2009,1,3)), (Date.new(2009,1,20)..Date.new(2009,1,22))]
    # Dates that should link off to individual days of debates
    linked = [Date.new(2009,1,12), Date.new(2009,1,31)]

    b.div(:class => "calendar") do
      b.table(:border => 0) do
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
            b.td({:colspan => "3"}) { b << "&nbsp;" }
            (1..3).each {|day| b.td({:class => "no", :title => "recess"}, day)}
            b.td 4
          end
          b.tr do
            (5..11).each {|day| b.td day}
          end
          b.tr do
            b.td { b.a({:href => "/debates/?d=2009-01-12"}, 12) }
            (13..18).each {|day| b.td day}
          end
          b.tr do
            b.td 19
            b.td({:class => "on", :title => "recess"}, 20)
            (21..22).each {|day| b.td({:class => "no", :title => "recess"}, day)}
            (23..25).each {|day| b.td day}
          end
          b.tr do
            (26..30).each {|day| b.td day}
            b.td { b.a({:href => "/debates/?d=2009-01-31"}, 31) }
            b.td({:colspan => 1}) { b << "&nbsp;" }
          end
        end
      end
    end
    b.comment! "end calendar"
    
    helper.calendar(2009, 1, Date.new(2009,1,20), recess, linked, 1).should == expected
  end
end
