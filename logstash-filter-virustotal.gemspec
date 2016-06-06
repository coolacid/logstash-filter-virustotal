Gem::Specification.new do |s|
  s.name = 'logstash-filter-virustotal'
  s.version         = '0.1.1'
  s.licenses = ['Apache License (2.0)']
  s.summary = "This filter queries the Virustotal API"
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["CoolAcid"]
  s.email = 'jakendall@gmail.com'
  s.homepage = "http://www.coolacid.net"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/   *.rb'] + Dir['bin/*']
  s.files += Dir['[A-Z]*'] + Dir['test/**/*']
  s.files.reject! { |fn| fn.include? "CVS" }
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_development_dependency 'logstash-devutils', '~> 1.0.0'
end
