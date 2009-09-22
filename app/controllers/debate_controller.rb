class DebateController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def hansard
    @extra_keywords = "House of Representatives and Senate debates"
    @title = "#{@extra_keywords} (OpenAustralia.org)"
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
    @recess = Recess.dates
  end
  
  def representative_debate
    @recess = Recess.dates

    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true

    if params[:d]
      # A single day of debates in the House of Representatives
      @date = Date.parse(params[:d])
      @extra_keywords = @date.to_s(:simple)
      @title = "#{@extra_keywords}: House debates (OpenAustralia.org)"
      # TODO: There should only be a previous and next date if there are debates on that day
      if @date == Date.new(2009,5,13)
        @next_date = @date + 1
      elsif @date == Date.new(2009,5,14)
        @previous_date = @date - 1
      end
      render :day
    elsif params[:y]
      @year = params[:y].to_i
      # A whole year of debates in the House of Representatives
      @extra_keywords = "Debates for  #{@year}"
      @title = "#{@extra_keywords}: House debates (OpenAustralia.org)"
      render :year
    else
      @subsection = Hansard.find_by_id(params[:id])
      if @subsection.section?
        # Find the first subsection and redirect to it
        r = Hansard.first(:conditions => {:section_id => @subsection.epobject_id}, :order => "hpos")
        redirect_to :id => r.id
      elsif @subsection.subsection?
        @section = @subsection.section
        @date = @subsection.hdate
        @speeches = Hansard.speeches_in_subsection(@subsection)
        @extra_keywords = "#{truncate(@subsection.to_s, :length => 38)}: #{@subsection.hdate.to_s(:simple)}"
        @title = "#{@extra_keywords}: House debates (OpenAustralia.org)"
        # Temporary HACK
        if @date == Date.new(2009,5,13)
          @previous_debate = Hansard.find_by_id("2009-05-13.1.1")
        elsif @date == Date.new(2009,5,14)
          @previous_debate = Hansard.find_by_id("2009-05-14.1.1")
        end
      else
        raise "Only know currently how to handle sections and subsections"
      end
    end
  end
  
  # Display a single speech
  def speech
    @speech = Hansard.find_by_id(params[:id])
    @previous_speech = @speech.previous_speech_within_subsection
    @next_speech = @speech.next_speech_within_subsection
    @extra_keywords = "#{truncate(@speech.just_text, :length => 38)}: #{@speech.hdate.to_s(:simple)}"
    @title = "#{@extra_keywords}: House debates (OpenAustralia.org)"
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
    @comments = @speech.comments(:order => "posted")
  end
end
