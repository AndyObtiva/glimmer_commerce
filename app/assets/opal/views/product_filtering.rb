require 'glimmer/web/component/multi_checkbox_dropdown'

require 'models/product'
require 'presenters/product_collection_presenter'

class ProductFiltering
  include Glimmer::Web::Component

  attributes :presenter

  markup {
    div {
      # reuse glimmer_web_components gem
      input(type: :text, class: 'filter-product-name', placeholder: 'product name filter') {
        value <=> [presenter, :filter_product_name]
      }
      label { 'Brand: ' }
      multi_checkbox_dropdown(values: Product::BRANDS) {
        selected_values <=> [presenter, :filter_product_brand]
      }
      label { 'Gender: ' }
      multi_checkbox_dropdown(values: Product::GENDERS) {
        selected_values <=> [presenter, :filter_product_gender]
      }
      label { 'Age: ' }
      multi_checkbox_dropdown(values: Product::AGES) {
        selected_values <=> [presenter, :filter_product_age]
      }
    }
  }
  
  style {
    r('.product-filtering .filter-product-name') {
      height 34
      padding_left 10
    }
    r('.product-filtering label') {
      height 40
      padding '5px 5px 5px 10px'
    }
    r('.product-filtering .multi-checkbox-dropdown') {
      display 'inline-block'
    }
  }
end
