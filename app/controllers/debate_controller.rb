class DebateController < ApplicationController
  def debate
    if params[:d]
      # A single day of debates in the House of Representatives
      render :day, :layout => false
    else
      @subsection = Hansard.find_by_id(params[:id])
      @speeches = Hansard.speeches_in_subsection(@subsection)
      @titles = [@subsection.to_s, @subsection.hdate.to_formatted_s(:simple), "House debates"]
      # Hack to deal with not entirely consistent behaviour of "Debates" menu
      @debates_menu_on = true
    end
  end
  
  # Display a single speech
  def speech
    @speech = Hansard.find_by_id(params[:id])
    @previous_speech = @speech.previous_speech_within_subsection
    @next_speech = @speech.next_speech_within_subsection
    @titles = [@speech.just_text, @speech.hdate.to_formatted_s(:simple), "House debates"]
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
  end
end
