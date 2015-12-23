# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "json"

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::VirusTotal < LogStash::Filters::Base

  config_name "virustotal"
  
  # Your VirusTotal API Key
  config :apikey, :validate => :string, :required => true
  
  # For filed containing the item to lookup. This can point to a field ontaining a File Hash or URL
  config :field, :validate => :string, :required => true

  # Lookup type
  config :lookup_type, :validate => :string, :default => "hash"

  # Where you want the data to be placed
  config :target, :validate => :string, :default => "virustotal"

  # Timeout waiting for resopnse
  config :timeout, :validate => :number, :default => 5

  public
  def register
    require "faraday"
  end # def register

  public
  def filter(event)

    baseurl = "https://www.virustotal.com"

    if @lookup_type == "hash"
      url = "/vtapi/v2/file/report"
    elsif @lookup_type == "url"
      url = "/vtapi/v2/url/report"
    elsif @lookup_type == "ip"
          url = "/vtapi/v2/ip-address/report"
    end

    connection = Faraday.new baseurl
    begin
      response = connection.get url do |req|
            if @lookup_type == "ip"
                  req.params[:ip] = event[@field]
                else
                  req.params[:resource] = event[@field]
                end
        req.params[:resource] = event[@field]
        req.params[:apikey] = @apikey
        req.options.timeout = @timeout
        req.options.open_timeout = @timeout
      end
      if response.body.length > 2
          result = JSON.parse(response.body)
          event[@target] = result
          # filter_matched should go in the last line of our successful code
          filter_matched(event)
      end

    rescue Faraday::TimeoutError
      @logger.error("Timeout trying to contact virustotal")

    end

  end # def filter
end # class LogStash::Filters::Example
