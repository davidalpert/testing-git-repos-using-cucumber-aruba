# frozen_string_literal: true

Given('I have installed my app into {string} within the current directory') do |install_dir|
  my_app = File.join(aruba.root_directory, 'bin', 'do-something')
  raise "'#{my_app}' not found; did you run 'make build'?" unless File.exist?(my_app)

  create_directory(install_dir)
  FileUtils.cp(my_app, File.join(aruba.current_directory, install_dir))
end