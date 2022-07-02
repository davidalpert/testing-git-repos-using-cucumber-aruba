# frozen_string_literal: true

Before('@announce-paths') do
  aruba.announcer.activate :paths

  aruba.announcer.announce(:paths, "root_directory:    #{aruba.root_directory}")
  aruba.announcer.announce(:paths, "working_directory: #{aruba.config.working_directory}")
  aruba.announcer.announce(:paths, "current_directory: #{aruba.current_directory}")
end

Before('@with-no-project-git-user') do
  @user_name = `git config --local user.name`.chomp
  @user_email = `git config --local user.email`.chomp
  `git config --local --unset user.name` unless @user_name.empty?
  `git config --local --unset user.email` unless @user_email.empty?
end

After('@with-no-project-git-user') do
  `git config --local --unset user.name`
  `git config --local --unset user.email`

  `git config --local --add user.name "#{@user_name}"` unless @user_name.empty?
  `git config --local --add user.email "#{@user_email}"` unless @user_email.empty?
end
