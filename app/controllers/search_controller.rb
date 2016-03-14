class SearchController < ApplicationController
  before_action :check_page, only: [:search]

  def search
    @solr = Solr::Connection.new(Rails.configuration.solr_host.to_s, :autocommit => :on )
    keyword = escape_characters_in_string(params[:keyword])
    query = "((name:#{keyword}))"
    select_obj = Solr::Request::Select.new(nil, {'q' => query, 'wt' => "xml", 'rows' => 2000, 'indent' => true})
    @result_total = @solr.send(select_obj)
    @result_products = get_result_solr(@result_total)
    @products = get_products(@result_products)
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

  def escape_characters_in_string(keyword)
    if keyword == ""
      flash[:danger] = "Keyword is null"
      redirect_to products_path
    else
      pattern = /(\+|\-|\&|\||\!|\(|\)|\{|\}|\[|\]|\^|\"|\~|\*|\?|\:|\ |\\)/
      return keyword.gsub(pattern){|match|"\\"  + match}
    end
  end

end
