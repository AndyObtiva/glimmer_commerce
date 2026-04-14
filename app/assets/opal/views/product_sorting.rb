require 'presenters/product_collection_presenter'

class ProductSorting
  include Glimmer::Web::Component

  attributes :presenter

  markup {
    div {
      label { 'Sort:' }
      select {
        value <=> [presenter, :sort_attribute]
        
        option(value: 'id') { 'Featured' }
        presenter.class::SORT_ATTRIBUTES.each do |sort_attribute|
          option(value: sort_attribute) { sort_attribute.capitalize }
        end
      }
      select {
        value <=> [presenter, :sort_direction]
        
        presenter.class::SORT_DIRECTIONS.each do |sort_direction, sort_direction_display|
          option(value: sort_direction) { sort_direction_display }
        end
      }
    }
  }
  
  style {
    r('.product-sorting') {
      margin_bottom 15
    }
    r('.product-sorting label') {
      height 40
    }
    r('.product-sorting select') {
      height 40
      padding 5
      margin_left 10
    }
  }
end
