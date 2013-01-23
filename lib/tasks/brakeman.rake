namespace :brakeman do

  desc "Run Brakeman"
  task :run, :output_files do |t, args|
    require 'brakeman'

    files = args[:output_files].split(' ') if args[:output_files]
    Brakeman.run(
      :app_path => ".",
      :output_files => files,
      :print_report => true,
      :skip_checks => ['CheckForgerySetting'],
      :exit_on_warn => true
    )
  end
end

task :default => 'brakeman:run'
