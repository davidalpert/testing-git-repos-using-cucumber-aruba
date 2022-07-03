# frozen_string_literal: true

require 'aruba'
require 'aruba/cucumber'

# Aruba ------------------------------------------------

# aruba file    matchers: https://github.com/cucumber/aruba/blob/master/lib/aruba/cucumber/file.rb
# aruba command matchers: https://github.com/cucumber/aruba/blob/master/lib/aruba/cucumber/command.rb

Aruba.configure do |config|
  config.exit_timeout = 1 # seconds
end

# Step Helpers -----------------------------------------------

Given(/PENDING/) do
  pending
end

module Example
  # syntax wrappers around arub commands
  module StepHelpers
    def home_dir
      relative_dir('~/')
    end

    def current_dir
      relative_dir('.')
    end

    def relative_dir(path)
      abs_dir(path).delete_prefix(aruba.root_directory)[1..]
    end

    def relative_dir_from_abs(path)
      path.delete_prefix(aruba.root_directory)[1..]
    end

    def abs_dir(path)
      expanded = path
      with_environment do
        expanded = expand_path(path)
      end
      expanded
    end
  end
end

# rubocop:disable Style/MixinUsage
# this extend is at the global scope deliberately, to make these helpers available in step definitions
include Example::StepHelpers
# rubocop:enable Style/MixinUsage
