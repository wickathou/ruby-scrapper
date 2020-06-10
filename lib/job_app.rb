require_relative '../lib/remote_jobs'
require 'tty-prompt'

class JobApp
  LANGUAGES = %w[ruby javascript ruby-on-rails java go].freeze
  def initialize
    @job_listings = {}
    app_start
  end

  def app_start
    repeat = true
    while repeat
      new_language
      new_search
      system 'clear'
      view_listings
      repeat = restart
    end
    puts 'Thank you for using Job App'
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
