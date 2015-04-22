# Logstash Plugin

This is a plugin for [Logstash](https://github.com/elasticsearch/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Documentation

Options:

apikey - This is your API Key from Virustotal
field - the field that contains the resource you want to query for 
lookup_type - The lookup type, either 'url' or 'hash' for a URL or File hash. Default: hash
target - Where you want the data to go within the event structure. Default: virustotal

```
input {
  generator {
    type => "generated"
    #message => '99017f6eebbac24f351415dd410d522d'
    message => "http://www.google.com"
    count => 1
  }
}

filter {
  virustotal {
    apikey => '[API KEY]'
    field => "message"
    lookup_type => "url"
  }
}

output {
    stdout { codec => rubydebug }
}
```

## Need Help?

Need help? Try #logstash on freenode IRC or the logstash-users@googlegroups.com mailing list.

Need help specificly to this plugin? Find @coolacid on Freenode IRC or twitter.

## Developing

### 1. Plugin Developement and Testing

#### Code
- To get started, you'll need JRuby with the Bundler gem installed.

- Create a new plugin or clone and existing from the GitHub [logstash-plugins](https://github.com/logstash-plugins) organization.

- Install dependencies
```sh
bundle install
```

#### Test

```sh
bundle exec rspec
```

The Logstash code required to run the tests/specs is specified in the `Gemfile` by the line similar to:
```ruby
gem "logstash", :github => "elasticsearch/logstash", :branch => "1.5"
```
To test against another version or a local Logstash, edit the `Gemfile` to specify an alternative location, for example:
```ruby
gem "logstash", :github => "elasticsearch/logstash", :ref => "master"
```
```ruby
gem "logstash", :path => "/your/local/logstash"
```

Then update your dependencies and run your tests:

```sh
bundle install
bundle exec rspec
```

### 2. Running your unpublished Plugin in Logstash

#### 2.1 Run in a local Logstash clone

- Edit Logstash `tools/Gemfile` and add the local plugin path, for example:
```ruby
gem "logstash-filter-awesome", :path => "/your/local/logstash-filter-awesome"
```
- Update Logstash dependencies
```sh
rake vendor:gems
```
- Run Logstash with your plugin
```sh
bin/logstash -e 'filter {awesome {}}'
```
At this point any modifications to the plugin code will be applied to this local Logstash setup. After modifying the plugin, simply rerun Logstash.

#### 2.2 Run in an installed Logstash

- Build your plugin gem
```sh
gem build logstash-filter-awesome.gemspec
```
- Install the plugin from the Logstash home
```sh
bin/plugin install /your/local/plugin/logstash-filter-awesome.gem
```
- Start Logstash and proceed to test the plugin

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members  saying "send patches or die" - you will not see that here.

It is more important to me that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elasticsearch/logstash/blob/master/CONTRIBUTING.md) file.
