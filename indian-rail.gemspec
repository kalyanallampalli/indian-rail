# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'indian-rail/version'

Gem::Specification.new do |gem|
  gem.name          = "indian-rail"
  gem.version       = IndianRail::VERSION
  gem.authors       = ["Kalyan Allampalli"]
  gem.email         = ["kalyan.allampalli@gmail.com"]
  gem.description   = %q{Client for the RESTful JSON Indian Rail}
  gem.summary       = %q{Indian Rail helps you get all the information you want to know about Indian Railways.}

  gem.files = [	
	"Gemfile",
	"Gemfile.lock",
	"LICENSE.txt",
	"README.md",
	"Rakefile",
	"lib/indian-rail.rb",
	"lib/indian-rail/version.rb",
	"lib/indian-rail/api.rb",
	"lib/indian-rail/pnr.rb",
	"lib/indian-rail/schedule.rb",	
	"indian-rail.gemspec"
  ]
  
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "nokogiri", "~> 1.5.9"
  gem.add_development_dependency "rspec", "~> 2.13.0"
  
end
