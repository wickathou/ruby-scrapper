require_relative '../lib/remote_jobs'
require 'tty-prompt'

class JobApp
  attr_reader :debug_message

  LANGUAGES = %w[ruby javascript ruby-on-rails java go].freeze
  def initialize(testing = nil)
    @job_listings = {}
    app_start(testing)
    puts @debug_message
  end

  private

  def app_start(testing = nil)
    repeat = true
    unless testing
      while repeat
        new_language
        new_search
        system 'clear'
        view_listings
        repeat = restart
      end
    else
      testing_mode
    end
    @debug_message = 'Thank you for using Job App'
  end

  def testing_mode
    @language = LANGUAGES[rand(0..4)]
    new_search
  end

  def new_language
    prompt = TTY::Prompt.new
    @language = prompt.enum_select('Choose a language to search', LANGUAGES)
  end

  def new_search
    @job_listings[@language] = RemoteJobs.new(@language).jobs
  end

  def view_listings
    @job_listings[@language].each do |listing|
      listing.each do |id, job|
        puts '-------------------'
        puts "#{id} 🌟"
        puts 'Details'
        puts "Job title: #{job[:title]}"
        puts "Company: #{job[:company]}"
        puts "Published: #{job[:published]}"
        puts '==================='
      end
    end
  end

  def restart
    TTY::Prompt.new.yes?('Make a new search?')
  end
end
