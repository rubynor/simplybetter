namespace :assets do
  desc "Precompile"
  task precompile: :environment do
    Rake::Task["precompile_static"].invoke
  end
end
