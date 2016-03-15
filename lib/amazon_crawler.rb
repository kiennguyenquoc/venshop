class AmazonCrawler
  attr_reader :request, :item_pages

  def initialize
    @request = Vacuum.new('US')
    @request.configure(
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      associate_tag: ENV["ASSOCIATE_TAG"]
    )
    @item_pages = (1..10).to_a
  end

  def import_products
    item_pages.each do |page|
      reponse = request.item_search(
        query: {
          "Keywords" => "*",
          "SearchIndex" => "Blended",
          "ResponseGroup" => "Medium",
          "ItemPage" => page
        }
      )
      items = reponse.to_h["ItemSearchResponse"]["Items"]["Item"]
      items.each do |item|
        import_product(item)
      end
    end
  end

  private

  def import_product(item)
    begin
      category = Category.find_or_create_by(name: item["ItemAttributes"]["ProductGroup"])
      Product.find_or_create_by(name: item["ItemAttributes"]["Title"]) do |product|
        product.image = item["LargeImage"]["URL"]
        product.price = item["ItemAttributes"]["ListPrice"]["Amount"].to_i
        product.description = item["EditorialReviews"]["EditorialReview"]["Content"]
        product.category = category
        product.save
        SolrModule.new.update_solr_index_after_import_product(product.id, product)
      end
    rescue Exception => e
      puts e
    end
  end
end
