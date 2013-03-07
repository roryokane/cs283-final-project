# encoding: utf-8

require_relative 'helper'

require_relative '../lib/converting'

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
	
	def compile_from_and_to_streams(input_stream, output_stream)
		input = input_stream.read
		output = convert_bc_to_c(input)
		output_stream.write(output)
	end
	
	def test_samples
		# TODO automatically iterate through all sample files in folder
		test_case_names = ["basic-full"]
		#test_case_names = ["basic-full", "k&r-cat-v2"]
		
		test_case_names.each do |test_case_name|
			
			output = ""
			with_input_stream_for_test_case(test_case_name) do |input_stream|
				output = string_output_from_using_output_stream do |output_stream|
					compile_from_and_to_streams(input_stream, output_stream)
				end
			end
			
			expected_output = expected_output_for_test_case(test_case_name)
			assert_equal expected_output, output
		end
	end
end
