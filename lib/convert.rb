require_relative 'converting'

input = STDIN.read
output = convert_bc_to_c(input)
puts output
