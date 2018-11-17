namespace :elasticsearch do
    desc 'Elasticsearch のindex作成'
    task :create_index => :environment do
        Lab.__elasticsearch__.create_index! force: true
    end

    desc 'Lab を Elasticsearch に登録'
    task :import_lab => :environment do
        Lab.import
    end
end
