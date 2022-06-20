# frozen_string_literal: true

Given('I set the local user config to {string} {string}') do |user_name, user_email|
  run_command_and_stop("git config --add user.name \"#{user_name}\"", fail_on_error: true)
  run_command_and_stop("git config --add user.email \"#{user_email}\"", fail_on_error: true)
end

Given('I set the global user config to {string} {string}') do |user_name, user_email|
  run_command_and_stop("git config --global --add user.name \"#{user_name}\"", fail_on_error: true)
  run_command_and_stop("git config --global --add user.email \"#{user_email}\"", fail_on_error: true)
end

Given('I set the repository user config to {string} {string}') do |user_name, user_email|
  repo_config_file = File.join(aruba.root_directory, '.git', 'config')
  run_command_and_stop("git config --file \"#{repo_config_file}\" --add user.name \"#{user_name}\"", fail_on_error: true)
  run_command_and_stop("git config --file \"#{repo_config_file}\" --add user.email \"#{user_email}\"", fail_on_error: true)
end

Then(/GIT_DIR should (not )?contain "([^"]*)"/) do |negated, content|
  run_command_and_validate_channel(
    cmd: "git rev-parse --show-toplevel",
    fail_on_error: true,
    channel: 'stdout',
    negated: negated,
    match_as_regex: false,
    content: content
  )
end

Then(/GIT_DIR should (not )?match "([^"]*)"/) do |negated, content|
  run_command_and_validate_channel(
    cmd: "git rev-parse --show-toplevel",
    fail_on_error: true,
    channel: 'stdout',
    negated: negated,
    match_as_regex: true,
    content: content
  )
end

Then(/git configuration should (not )?contain "([^"]*)"/) do |negated, content|
  run_command_and_validate_channel(
    cmd: "git config --list --show-origin",
    fail_on_error: true,
    channel: 'stdout',
    negated: negated,
    match_as_regex: false,
    content: content
  )
end

Then(/git configuration should (not )?match "([^"]*)"/) do |negated, content|
  run_command_and_validate_channel(
    cmd: "git config --list --show-origin",
    fail_on_error: true,
    channel: 'stdout',
    negated: negated,
    match_as_regex: true,
    content: content
  )
end

Then(/the repository git config file should (not )?contain "([^"]*)"/) do |negated, content|
  repo_config_file = File.join(aruba.root_directory, '.git', 'config')
  # puts "repo_config_file: #{repo_config_file}"
  repo_config = File.read(repo_config_file)
  # puts "repo_config:\n---\n#{repo_config}\n---\n"

  if negated
    expect(repo_config).not_to file_content_including(content.chomp)
  else
    expect(repo_config).to file_content_including(content.chomp)
  end
end

Given(/the repository git config file has (a|no) user section/) do |presence|
  repo_config_file = File.join(aruba.root_directory, '.git', 'config')
  repo_config = File.read(repo_config_file)
  if presence == 'a'
    expect(repo_config).to file_content_including('[user]')
  elsif presence == 'no'
    expect(repo_config).not_to file_content_including('[user]')
  end
end