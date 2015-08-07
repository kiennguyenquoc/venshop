class SearchController < ApplicationController
  before_action :check_page, only: [:search]

=begin
  def search
    if params[:keyword].nil?
      @products = []
    else
      @products = Product.search(params[:keyword]).paginate(page: params[:page]).per_page(18)
    end
  end
=end

  def search
    @solr = Solr::Connection.new(Rails.configuration.solr_host.to_s, :autocommit => :on )
    keyword = params[:keyword]
    query = "((name:#{keyword}))"
    select_obj = Solr::Request::Select.new(nil, {'q' => query, 'wt' => "xml", 'rows' => 2000, 'indent' => true})
    if keyword.index( /[^[:alnum:]]/ ) == nil
      @result_total = @solr.send(select_obj)
      @result_products = get_result_solr(@result_total)
      @products = get_products(@result_products)
    else
       @products = []
    end
  end

  private

  def get_result_solr(result_total)
    products = result_total.data['response']['docs']
  end

  def get_products(result_products)
    products = Array.new
    result_products.each do |iProduct|
      product = Product.find(iProduct['id'])
      products << product
    end
    return products
  end

end
