# frozen_string_literal: true

module Idnow
  class DocumentDefinition
    include Idnow::Jsonable

    attr_accessor :optional, :name, :identifier, :mime_type, :sort_order

    def initialize(data)
      @optional = data['optional']
      @name = data['name']
      @identifier = data['identifier']
      @mime_type = data['mimeType']
      @sort_order = data['sortOrder']
    end
  end
end
