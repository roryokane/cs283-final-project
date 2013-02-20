# encoding: utf-8

require 'sinatra'

def convert_bc_to_c(better_c)
	better_c.reverse
end

get '/convert' do
	input = request.body.string
	convert_bc_to_c(input)
end
