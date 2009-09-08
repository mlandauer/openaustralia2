class DebateController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def hansard
    render :layout => false
  end
  
  def debate
    # Dates that parliament is in recess
    @recess = [
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

    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true

    if params[:d]
      # A single day of debates in the House of Representatives
      @date = Date.parse(params[:d])
      @extra_keywords = @date.to_formatted_s(:simple)
      @title = "#{@extra_keywords}: House debates"
      render :day
    elsif params[:y]
      @year = params[:y].to_i
      # A whole year of debates in the House of Representatives
      @extra_keywords = "Debates for  #{@year}"
      @title = "#{@extra_keywords}: House debates"
      render :year
    else
      @subsection = Hansard.find_by_id(params[:id])
      @speeches = Hansard.speeches_in_subsection(@subsection)
      @extra_keywords = "#{truncate(@subsection.to_s, :length => 38)}: #{@subsection.hdate.to_formatted_s(:simple)}"
      @title = "#{@extra_keywords}: House debates"
    end
  end
  
  # Display a single speech
  def speech
    @speech = Hansard.find_by_id(params[:id])
    @previous_speech = @speech.previous_speech_within_subsection
    @next_speech = @speech.next_speech_within_subsection
    @extra_keywords = "#{truncate(@speech.just_text, :length => 38)}: #{@speech.hdate.to_formatted_s(:simple)}"
    @title = "#{@extra_keywords}: House debates"
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
  end
end
