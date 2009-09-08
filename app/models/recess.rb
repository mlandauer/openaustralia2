class Recess
  # Date ranges that parliament is in recess
  def Recess.dates
    [
    	(Date.new(2007,12, 7)..Date.new(2008, 2,11)),
    	(Date.new(2008, 2,23)..Date.new(2008, 3,10)),
    	(Date.new(2008, 3,21)..Date.new(2008, 5,12)),
    	(Date.new(2008, 5,17)..Date.new(2008, 5,25)),
    	(Date.new(2008, 6, 7)..Date.new(2008, 6,15)),
    	(Date.new(2008, 6,27)..Date.new(2008, 8,25)),
    	(Date.new(2008, 9, 6)..Date.new(2008, 9,14)),
    	(Date.new(2008, 9,27)..Date.new(2008,10,12)),
    	(Date.new(2008,10,18)..Date.new(2008,11, 9)),
    	(Date.new(2008,11,15)..Date.new(2008,11,23)),
    	(Date.new(2008,12, 5)..Date.new(2009, 2, 2)),
    	(Date.new(2009, 2,13)..Date.new(2009, 2,22)),
    	(Date.new(2009, 2,27)..Date.new(2009, 3, 9)),
    	(Date.new(2009, 3,20)..Date.new(2009, 5,11)),
    	(Date.new(2009, 5,15)..Date.new(2009, 5,24)),
    	(Date.new(2009, 6, 5)..Date.new(2009, 6,14)),
    	(Date.new(2009, 6,26)..Date.new(2009, 8,10)),
    	(Date.new(2009, 8,21)..Date.new(2009, 9, 6)),
    	(Date.new(2009, 9,18)..Date.new(2009,10,18)),
    	(Date.new(2009,10,30)..Date.new(2009,11,15)),
    	(Date.new(2009,11,27)..Date.new(2009,12,31))
    ]
  end
end