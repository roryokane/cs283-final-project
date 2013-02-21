# encoding: utf-8

require 'sinatra'
require_relative 'converting'
require_relative 'config_loader'

CONFIG = ConfigLoader.new.config_for("server")

# GET is appropriate because the result is idempotent; conversions always work the same way
get '/convert' do
	input = request.body.string
	convert_bc_to_c(input)
end
