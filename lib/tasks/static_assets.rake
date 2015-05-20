require 'fileutils'
desc "Precompile assets with no digest from the static folder to public/"
task precompile_static: :environment do
  # We only handle CSS atm. Will need to expand if we want it
  # to work with all kinds of assets
  BASE_PATH = "app/assets/stylesheets/static/"

  def precompile_all_in_path
    files_to_precompile.each do |path|
      precompile(path.gsub('app/assets/stylesheets/', ''))
    end
  end

  def files_to_precompile
    Dir.glob("#{BASE_PATH}**/*").reject {|fn| File.directory?(fn) }
  end

  def precompile(path)
    precompiled_asset = Rails.application.assets.find_asset(path).to_s
    File.write(public_path(path), precompiled_asset)
    puts "Write file: " + public_path(path)
  end

  def public_path(path)
    full_path = "#{Rails.root.to_s}/public/assets/#{path.gsub(BASE_PATH, '')}"
    full_path.rpartition('.').first # Use only the first file ending(.css)
  end

  def create_folders
    folders.each do |path|
      stripped_path = "#{Rails.root.to_s}/public/assets/static/#{path.gsub(BASE_PATH, '')}"

      begin
        FileUtils.mkdir_p stripped_path
      rescue Errno::EEXIST => e
        puts "Folder already exists: #{stripped_path}"
      end
    end
  end

  def folders
    Dir.glob("#{BASE_PATH}**/*/")
  end

  create_folders()
  precompile_all_in_path()
end
