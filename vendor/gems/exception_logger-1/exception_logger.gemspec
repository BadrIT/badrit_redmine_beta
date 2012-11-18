# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'bundler/version'
 
Gem::Specification.new do |s|
  s.name        = "exception_logger"
  s.version     = "0.1.10"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Wise"]
  s.email       = ["cwise@murmurinformatics.com"]
  s.homepage    = "http://github.com/cwise/exception_logger"
  s.summary     = "Fork of exception_logger gem"
  s.description = "Fork of exception_logger gem"
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.files        = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
end