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

class TestIntegratedConversions < MiniTest::Unit::TestCase
	def with_input_stream_for_test_case(filename)
		File.open("test/test-cases/#{filename}.betterc", 'r') do |input_stream|
			yield(input_stream)
		end
	end
	
	def expected_output_for_test_case(name)
		File.read("test/test-cases/#{name}.c")
	end
	
	def string_output_from_using_output_stream
		output = ""
		StringIO.open(output, 'w') do |output_stream|
			yield(output_stream)
		end
		output
	end
	
	def test_samples
		# TODO automatically iterate through all sample files
		(1..3).each do |sample_number|
			
			output = ""
			with_input_stream_for_test_case("sample#{sample_number}") do |input_stream|
				output = string_output_from_using_output_stream do |output_stream|
					export_graph_from_stream(input_stream, output_stream)
				end
			end
			
			expected_output = expected_output_for_test_case("sample#{sample_number}")
			assert_equal expected_output, output
		end
	end
end
