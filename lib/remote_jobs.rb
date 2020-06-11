require_relative '../lib/scrapper'

class RemoteJobs
  attr_reader :jobs, :job_ids, :debug_message
  include Scrapper
  def initialize(language)
    @jobs = []
    @job_ids = []
    execution_mode(language)
  end

  private

  def execution_mode(language)
    job_log(language)
    language == 'exception' ? raise : @debug_message = 'Search complete'
  rescue StandardError => e
    puts e
    puts 'Something went wrong, try again'
    @debug_message = 'Exception catched'
  end

  def language_jobs(language)
    @current_search = parsing(language)
  end

  def job_log(language)
    language_jobs(language)
    id_finder(language)
    job_post_finder(language)
  end

  def id_finder(_language)
    @current_search.css('tr.job').each do |node|
      @job_ids << node.attributes['data-id'].value
    end
  end

  def post_details?(id)
    @current_search.css("tr.job-#{id}") && @current_search.css("tr.expand-#{id}")
  end

  def job_post_finder(language)
    @job_ids.each do |id|
      next unless post_details?(id)

      @jobs << { "#{language} job - id #{id}" => {
        company: @current_search.css("tr.job-#{id}").css('h3').select { |node| node.attributes['itemprop'] }[0].text,
        title: @current_search.css("tr.job-#{id}").css('h2').select { |node| node.attributes['itemprop'] }[0].text,
        published: @current_search.css("tr.job-#{id}").css('td.time')[0].text
      } }
    end
  end
end
