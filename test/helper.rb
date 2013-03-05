# encoding: utf-8

require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!


def assert_all_equal_after_processing(input_expected_map, &process)
	input_expected_map.each do |input, expected|
		actual = process.call(input)
		assert_equal(expected, actual)
	end
end