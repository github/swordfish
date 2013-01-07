namespace :extension do
  EXTENSIONS_DIR = Rails.root.join('extensions')
  BUILD_DIR      = Rails.root.join('build', 'extensions')
  CHROME_KEY     = Rails.root.join('build', 'chrome.pem')

  desc "Add #{EXTENSIONS_DIR} to asset paths"
  task :environment do
    Rails.application.config.assets.paths << EXTENSIONS_DIR.to_s
    Rake::Task['environment'].invoke

    # load sprockets extensions
    Rails.application.assets.context_class.instance_eval do
      include ::Sprockets::Helpers::IsolatedHelper
      include ::Sprockets::Helpers::RailsHelper
    end
  end

  task :clean do
    FileUtils.rm_rf BUILD_DIR.to_s
  end

  def build(target)
    Dir.glob(EXTENSIONS_DIR.join(target, '**', '*.*')).each do |template|
      asset = Rails.application.assets[template]
      output = BUILD_DIR.join asset.logical_path
      FileUtils.mkdir_p File.dirname(output)
      File.open(output, 'wb') {|f| f << asset.to_s }
    end
  end

  namespace :chrome do
    desc 'Build Google Chrome extension'
    task :build => 'extension:environment' do
      build 'chrome'
    end

    desc "Package Google Chrome extension"
    task :package => :build do
      dir = BUILD_DIR.join('chrome')
      FileUtils.mkdir_p dir
      options = {
        :ex_dir      => dir,
        :crx_output  => "build/extensions/swordfish.crx",
        :ignorefile  => /\.swp/,
        :ignoredir   => /\.(?:svn|git|cvs)/
      }
      options[CHROME_KEY.exist? ? :pkey : :pkey_output] = CHROME_KEY.to_s

      CrxMake.make(options)
    end
  end
end

task 'cucumber:ok' => 'extension:chrome:package'
