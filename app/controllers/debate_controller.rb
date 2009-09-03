class DebateController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def debate
    if params[:d]
      # A single day of debates in the House of Representatives
      @date = Date.parse(params[:d])
      @extra_keywords = @date.to_formatted_s(:simple)
      @title = "#{@extra_keywords}: House debates"
      @debates_menu_on = true    
      render :day
    else
      @subsection = Hansard.find_by_id(params[:id])
      @speeches = Hansard.speeches_in_subsection(@subsection)
      @extra_keywords = "#{truncate(@subsection.to_s, :length => 38)}: #{@subsection.hdate.to_formatted_s(:simple)}"
      @title = "#{@extra_keywords}: House debates"
      # Hack to deal with not entirely consistent behaviour of "Debates" menu
      @debates_menu_on = true
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
