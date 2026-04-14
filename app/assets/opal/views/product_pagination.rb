require 'glimmer-dsl-web'

require 'presenters/product_collection_presenter'

class ProductPagination
  include Glimmer::Web::Component

  attributes :presenter

  markup {
    div {
      content(presenter, :pages) do
        p { "Displaying page #{presenter.page} of #{presenter.page_count}" }
        ul(class: 'pages') {
          presenter.pages.each do |page|
            li {
              a(page, href: "/products?page=#{page}") {
                onclick do |event|
                  event.prevent_default
                  presenter.go_to_page(page)
                end
              }
            }
          end
        }
      end
    }
  }
  
  style {
    r('.product-pagination ul.pages') {
      padding 0
    }
    r('.product-pagination ul.pages li') {
      display :inline
      padding '0 5px'
    }
  }
end
