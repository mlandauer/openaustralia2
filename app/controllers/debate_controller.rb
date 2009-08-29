class DebateController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def debate
    if params[:d]
      # A single day of debates in the House of Representatives
      @titles = ["14 May 2009", "House debates"]
      @title = @titles.map{|t| truncate(t, :length => 38)}.join(': ')
      @extra_keywords = @titles[0..1].map{|t| truncate(t, :length => 38)}.join(': ')
      render :day, :layout => false
    else
      @subsection = Hansard.find_by_id(params[:id])
      @speeches = Hansard.speeches_in_subsection(@subsection)
      @titles = [@subsection.to_s, @subsection.hdate.to_formatted_s(:simple), "House debates"]
      @title = @titles.map{|t| truncate(t, :length => 38)}.join(': ')
      @extra_keywords = @titles[0..1].map{|t| truncate(t, :length => 38)}.join(': ')
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
    @title = @titles.map{|t| truncate(t, :length => 38)}.join(': ')
    @extra_keywords = @titles[0..1].map{|t| truncate(t, :length => 38)}.join(': ')
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
  end
end
