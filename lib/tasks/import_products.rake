namespace :products do
  desc 'Get products database Amazone'
  task import: :environment do
    AmazonCrawler.new.import_products
  end

end