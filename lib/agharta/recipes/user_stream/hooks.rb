# -*- coding: utf-8 -*-
module Agharta
  module Recipes
    module UserStream
      module Hooks
        def hooks
          @hooks ||= []
        end

        def keyword(*args, &block)
          hook = Keyword.new(self, *args, &block)
          hooks << hook
          hook
        end

        def user(*args, &block)
          hook = User.new(self, *args, &block)
          hooks << hook
          hook
        end

        def event(*args, &block)
          hook = Event.new(self, *args, &block)
          hooks << hook
          hook
        end
      end
    end
  end
end

require 'agharta/recipes/user_stream/hooks/hook'
require 'agharta/recipes/user_stream/hooks/keyword'
require 'agharta/recipes/user_stream/hooks/user'
require 'agharta/recipes/user_stream/hooks/event'
