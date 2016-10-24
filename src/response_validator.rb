require 'json-schema'
require 'pry'

class ResponseValidator
	attr_reader :json_document

	def initialize(json_document)
		@json_document = json_document
	end

	def validate_response_for_json_document(schema)
		begin
			output = JSON::Validator.fully_validate(schema, @json_document)
			return (output.size == 0 ? { status: true } : { status: false, errors: output})
		rescue JSON::Schema::ValidationError => e
			e.message
		end

	end
end