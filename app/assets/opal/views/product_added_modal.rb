require 'glimmer-dsl-web'

require 'models/product'

class ProductAddedModal
  include Glimmer::Web::Component

  markup {
    div(class: 'modal-outer') {
      div(class: 'modal-inner') {
        h2 { 'Item has been added to cart.' }
        
        div {
          button('Continue shopping') {
            onclick do
              markup_root.remove
              $$.document.location.href = '/'
            end
          }
          
          button('Go to cart') {
            onclick do
              markup_root.remove
              $$.document.location.href = '/orders/shopping_cart'
            end
          }
        }
      }
    }
  }
  
  style {
    r('.product-added-modal.modal-outer') {
      display 'flex'
      position 'fixed'
      left 0
      top 0
      width 100.vw
      height 100.vh
      background 'rgba(200, 200, 200, 0.8)'
      margin 0
      padding 0
      justify_content 'center'
      align_items 'center'
    }
    
    r('.product-added-modal div.modal-inner') {
      display 'flex'
      flex_direction 'column'
      width 300
      height 100
      justify_content 'center'
      align_items 'center'
      box_shadow '0 10px 30px rgba(0, 0, 0, 0.5)'
      background :white
      border_radius 15
      padding 15
    }
    
    r('.product-added-modal div.modal-inner button') {
      width 135
      margin 5
      border_radius 5
      padding 5
      background :white
    }
    
    r('.product-added-modal div.modal-inner button:hover') {
      background :black
      color :white
    }
  }
end
