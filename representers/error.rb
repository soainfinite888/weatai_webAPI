require 'json'

# Represents overall group information for JSON API output
class ErrorRepresenter < Roar::Decorator
  property :code
  property :message

  ERROR = {
    not_found: 404,
  }.freeze

  def to_status_response
    [ERROR[@represented.code], { errors: [@represented.message] }.to_json]
  end
end
