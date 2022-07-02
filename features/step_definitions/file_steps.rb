# frozen_string_literal: true

Then(/the (full )?path of "([^"]+)" should (not )?contain "([^"]+)"/) do |_, path, negated, content|
  if negated
    expect(expand_path(path)).not_to include_output_string(content)
  else
    expect(expand_path(path)).to include_output_string(content)
  end
end

Then(/the (full )?path of "([^"]+)" should (not )?match "([^"]+)"/) do |_, path, negated, content|
  if negated
    expect(expand_path(path)).not_to match_output_string(content)
  else
    expect(expand_path(path)).to match_output_string(content)
  end
end

Then(/the (current|present) working directory should (not )?contain "([^"]+)"/) do |_, negated, content|
  run_command_and_validate_channel(
    cmd: 'pwd',
    fail_on_error: true,
    channel: 'stdout',
    negated: negated,
    match_as_regex: false,
    content: content
  )
end

Then(/the (current|present) working directory should (not )?match "([^"]+)"/) do |_, negated, content|
  run_command_and_validate_channel(
    cmd: 'pwd',
    fail_on_error: true,
    channel: 'stdout',
    negated: negated,
    match_as_regex: true,
    content: content
  )
end
