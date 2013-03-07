# encoding: utf-8

require_relative 'helper'

require_relative '../lib/solver'

class TestParser < MiniTest::Unit::TestCase
	def setup
		@parser = Parser.new
	end
	
	def test_state_after_reading_input
		assert_all_equal_after_processing({
			"a" => [],
			"(" => [:paren],
			"a(b(c" => [:paren, :paren],
			"'foo" => [:single_quote],
			"'foo'" => [],
		}) do |input|
			@parser.simulate(input)
			@parser.state_stack
		end
	end
end
