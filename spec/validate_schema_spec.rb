require 'spec_helper'
require 'json'
require_relative '../src/response_validator'

describe ResponseValidator do
	it 'should return true for correct book response' do
		response_validator = ResponseValidator.new(read_resource('book.json'))
		response  = response_validator.validate_response_for_json_document(read_schema('book_schema.json'))
		expect(response[:status]).to eq true
	end

	it 'should return false when mandatory fields are missing' do
		response_validator = ResponseValidator.new(read_resource('book_mandatory_filed_missing.json'))
		response  = response_validator.validate_response_for_json_document(read_schema('book_schema.json'))
		expect(response[:status]).to eq false
		puts "Failed: #{response[:errors]}"
	end

	def read_resource(resource_file)
		file_path = File.expand_path(File.dirname(__FILE__) + "/../resources/#{resource_file}")
		contents  = JSON.parse(File.read(file_path))
		contents
	end

	def read_schema(schema_file)
		file_path = File.expand_path(File.dirname(__FILE__) + "/../schema/#{schema_file}")
		contents  = JSON.parse(File.read(file_path))
		contents
	end
end

