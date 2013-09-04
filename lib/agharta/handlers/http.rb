# -*- coding: utf-8 -*-

require 'faraday'
require 'agharta/handleable'
require 'agharta/status_formatter'

module Agharta
  module Handlers
    class Http
      include Handleable

      def initialize(context, *args, &block)
        @args = args
        @block = block
      end

      def call(status, options = {})
        data = StatusFormatter.call(status, options)
        Faraday.send(*@args) do |req|
          @block.call(req, data) if @block
        end
      end
    end
  end
end
