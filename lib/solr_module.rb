class SolrModule

  def initialize
    @solr = RSolr.connect :url => Rails.configuration.solr_host.to_s
  end

  def update_solr_index_after_import_product(id, product)
    %x{curl 'localhost:8080/solr/venshop/update?commit=true' -H 'Content-type:application/json' -d '[{"id":"#{id}","name":{"set":"#{product.name}"}, "category_id":"#{product.category_id}"}]'}
  end

  def delete_solr_index_after_delete_product(id)
    @solr.delete_by_id id
    @solr.commit
    @solr.optimize
  end

  def create_solr_index_after_create_product(id, name, price, description)
    doc = [{:id => id,:name => name, :price => price, :description => description}]
    @solr.add doc
    @solr.commit
    @solr.optimize
  end

end