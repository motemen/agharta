# -*- coding: utf-8 -*-

require 'agharta/user_stream/hooks/event'
require 'agharta/user_stream/hooks/keyword'
require 'agharta/user_stream/hooks/user'

module Agharta
  module UserStream
    module Hooks
      # Return list of hook objects
      #
      # @return [Array<Agharta::UserStream::Hooks::Hook>]
      def hooks
        @hooks ||= []
      end

      # Add hook object to list
      #
      # @param hook [Agharta::UserStream::Hooks::Hook]
      # @return [Agharta::UserStream::Hooks::Hook]
      def add_hook(hook)
        hooks << hook
        hook
      end

      # Add event hook to list
      #
      # @see Agharta:UserStream::Hooks::Event
      # @overload event(*on, options = {})
      #   @param on [Array<Symbol>] Receive event
      #   @param options [Hash]
      #   @option options [Boolean] :all (false) Receive all event statuses
      #   @option options [Boolean] :ignore_self (false) Ignore self statuses
      #   @yield [status, options] Add block to handler when arity greater than zero
      #   @yield Evaluate as event hook context when arity is zero
      #   @yieldparam [Hash] status
      #   @yieldparam [Hash] options
      #   @return [Agharta::UserStream::Hooks::Event]
      #   @example Receive favorite event & log to stdout
      #     client.event(:favorite) { |status, options| puts status[:target_object][:text] }
      #   @example Receive all events & log to file with log handler
      #     client.event(:all => true) { log 'event.log' }
      def event(*args, &block)
        add_hook(Event.new(self, *args, &block))
      end

      # Add keyword hook to list
      #
      # @see Agharta::UserStream::Hooks::Keyword
      # @overload keyword(*includes, options = {})
      #   @param includes [Array<String, Regexp>] Receive keywords
      #   @param options [Hash]
      #   @option options [Array<String, Regexp>] :exclude ([]) Exclude keywords
      #   @option options [Boolean] :ignore_self (false) Ignore self statuses
      #   @yield [status, options] Add block to handler when arity greater than zero
      #   @yield Evaluate as event hook context when arity is zero
      #   @yieldparam [Hash] status
      #   @yieldparam [Hash] options
      #   @return [Agharta::UserStream::Hooks::Keyword]
      #   @example Receive "twitter" keyword & log to stdout
      #     client.event('twitter') { |status, options| puts status[:text] }
      #   @example Receive "twitter" keyword & log to file with log handler
      #     client.event('twitter') { log 'twitter.log' }
      def keyword(*args, &block)
        add_hook(Keyword.new(self, *args, &block))
      end

      # Add user hook to list
      #
      # @see Agharta::UserStream::Hooks::User
      # @overload user(*includes, options = {})
      #   @param includes [Array<String>] Receive user screen names
      #   @param options [Hash]
      #   @option options [Boolean] :all (false) Receive all user statuses
      #   @option options [Boolean] :ignore_self (false) Ignore self statuses
      #   @yield [status, options] Add block to handler when arity greater than zero
      #   @yield Evaluate as event hook context when arity is zero
      #   @yieldparam [Hash] status
      #   @yieldparam [Hash] options
      #   @return [Agharta::UserStream::Hooks::User]
      #   @example Receive tumblr statuses & log to stdout
      #     client.user('tumblr') { |status, options| puts status[:text] }
      #   @example Receive all user statuses & log to file with log handler
      #     client.event(:all => true) { log 'user.log' }
      def user(*args, &block)
        add_hook(User.new(self, *args, &block))
      end
    end
  end
end
