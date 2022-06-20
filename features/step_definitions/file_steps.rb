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