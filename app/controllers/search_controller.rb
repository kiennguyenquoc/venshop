class SearchController < ApplicationController
  before_action :check_page, only: [:search]
  VALID_PATTERN = /(\+|\-|\&|\||\!|\(|\)|\{|\}|\[|\]|\^|\"|\~|\*|\?|\:|\ |\\)/

  def search
    @solr = Solr::Connection.new(Rails.configuration.solr_host.to_s, :autocommit => :on )
    keyword = escape_characters_in_string(params[:keyword])
    query = "((name:#{keyword}))"
    select_obj = Solr::Request::Select.new(nil, {'q' => query, 'wt' => "xml", 'rows' => 2000, 'indent' => true})
    result_total = @solr.send(select_obj)
    result_products = get_result_solr(result_total)
    @products = get_products(result_products)
  end

  private

  def get_result_solr(result_total)
    products = result_total.data['response']['docs']
  end

  def get_products(result_products)
    products = []
    result_products.each do |iProduct|
      products << Product.find(iProduct['id'])
    end
    return products
  end

  def escape_characters_in_string(keyword)
    return keyword.gsub(VALID_PATTERN){|match|"\\"  + match} unless keyword.blank?
    redirect_to products_path, :danger => "Keyword is null"
  end

end
