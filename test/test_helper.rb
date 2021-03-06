require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end
require 'date'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/date_range'
require_relative '../lib/hotel_block'
require_relative '../lib/hotel_reception'
require_relative '../lib/reservation'
require_relative '../lib/room'