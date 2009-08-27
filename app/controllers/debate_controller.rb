class DebateController < ApplicationController
  def debate
    raise "at the moment this method should only work for one id value" unless params[:id] == "2009-05-14.1.2"
    
    @subsection = Hansard.find_by_id(params[:id])
    # Temporary
    @speeches = [Hansard.find_by_id("2009-05-14.2.1"), Hansard.find_by_id("2009-05-14.2.2")]
    
    @titles = [@subsection.to_s, "14 May 2009", "House debates"]
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
  end
  
  # Display a single speech
  def speech
    @speech = Hansard.find_by_id(params[:id])
    @previous_speech = @speech.previous_speech_within_subsection
    @next_speech = @speech.next_speech_within_subsection
    @member = @speech.speaker

    @titles = [@speech.just_text, @speech.hdate.to_formatted_s(:simple), "House debates"]
    @debates_menu_on = true
  end
end
