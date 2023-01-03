if Rails.env.development?
  namespace :db do

    desc 'Recreate database with seed for development environment'
    task recreate: :environment do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke

      p 'Done...'
    end

    desc 'Recreate database via dump file'
    # Note: example of rake command with specific path.
    # rake db:dump_recreate['~/Desktop/test_data.dump']

    task :dump_recreate, [:path_to_dump] => :environment do |t, args|
      args.with_defaults(path_to_dump: '~/Desktop/dump.dump')

      db_username = ENV.fetch('DB_USERNAME')
      db_name = ENV.fetch('DB_NAME')

      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke

      # BB
      #p 'Input: '
      #p "pg_restore --verbose --no-acl --no-owner --clean --jobs 4 -h localhost -U #{db_username} -d #{db_name} #{args[:path_to_dump]}"

      system "pg_restore --verbose --no-acl --no-owner --clean --jobs 4 -h localhost -U #{db_username} -d #{db_name} #{args[:path_to_dump]}"

      Rake::Task['db:migrate'].invoke

      p 'Done...'
    end

  end
end
