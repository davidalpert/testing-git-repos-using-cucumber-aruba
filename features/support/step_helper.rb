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

    # this helper provides some common logic around running a specific
    # command using Aruba's environment and path resolution, then
    # inspecting that output and matching it either as a regex match
    # or a string contains
    def run_command_and_validate_channel(cmd: '', fail_on_error: true, channel: 'stdout', negated: false, match_as_regex: false, content: '')
      run_command_and_stop(cmd, fail_on_error: fail_on_error)

      matcher = case channel
                when 'output'; then :have_output
                when 'stderr'; then :have_output_on_stderr
                when 'stdout'; then :have_output_on_stdout
                end

      command = aruba.command_monitor.find(Aruba.platform.detect_ruby(cmd))

      output_string_matcher = if match_as_regex
                                :an_output_string_matching
                              else
                                :an_output_string_including
                              end

      if negated
        expect(command).not_to send(matcher, send(output_string_matcher, content))
      else
        expect(command).to send(matcher, send(output_string_matcher, content))
      end
    end
  end
end

# rubocop:disable Style/MixinUsage
# this extend is at the global scope deliberately, to make these helpers available in step definitions
include Example::StepHelpers
# rubocop:enable Style/MixinUsage
