# Glimmer Commerce
## Rails Web App for Building Rails SPAs in Frontend Ruby with Glimmer DSL for Web at Wroclove.rb Ruby Conference 2026
### Author: Andy Maleh (Fukuoka 2022/2025 Winner / RubyConf/RailsConf Speaker / Ruby OSS Author / MS in Software Engineering)

Glimmer Commerce is a Ruby on Rails e-commerce web application that will be developed through a series of step-by-step
exercises at the Wroclove.rb 2026 Ruby Conference using [Opal Ruby](https://opalrb.com/) in the Frontend of Rails and [Glimmer DSL for Web](https://github.com/AndyObtiva/glimmer-dsl-web),
a Ruby-in-the-Browser Frontend Framework for Rails that [won a Fukuoka Prefecture Future IT Initiative 2025 award](https://andymaleh.blogspot.com/2025/01/glimmer-dsl-for-web-wins-in-fukuoka.html)
by Matz, the creator of Ruby, and other Fukuoka competition judges.

Please make sure to setup this project on your machine ahead of the conference workshop, as per the setup instructions below.

Check back on April 15, 2026 (2 days before the workshop) to pull the most up-to-date version of this project's code before
the workshop takes place on April 17, 2026 at 14:00.

Given that the Wroclove.rb event will be a workshop, we will quickly hit the ground running at the event through a series of hands-on
exercises without going through a long presentation, so it would be recommended that you familiarize yourself with
[Glimmer DSL for Web](https://github.com/AndyObtiva/glimmer-dsl-web) in advance by going through some project material on your own first:
- [Required] Fukuoka Prefecture Future IT Initiative 2025 Award Slide Deck: https://andymaleh.blogspot.com/2025/01/glimmer-dsl-for-web-wins-in-fukuoka.html
- [Optional] Glimmer DSL for Web GitHub: https://github.com/AndyObtiva/glimmer-dsl-web (if possible, read through Usage, Hello World, Hello Button, Hello Observer Data-Binding, Hello Form MVP, and Hello glimmer_component Rails Helper!)
- [Optional] Frontend Ruby with Glimmer DSL for Web at Ruby on Rio 2025-06-06: https://www.youtube.com/watch?v=LY6ulYICuzE
- [Optional] Frontend Ruby with Glimmer DSL for Web at /dev/mtl 2024: https://www.youtube.com/watch?v=J2VIY9DMJo4

## Setup Instructions

Run:
```
git clone https://github.com/AndyObtiva/glimmer_commerce.git
cd glimmer_commerce
bundle
rails db:setup
rails s
```

Visit localhost:3000, click test button, and make sure you see a message confirming test success,
to ensure Opal Ruby is working in the Frontend of the Rails web application.

Check back on April 15, 2026 (2 days before the workshop) to pull the most up-to-date version of this project's code before the workshop takes place on April 17, 2026 at 14:00:
```
git pull
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

## Exercises

At the workshop (about 10 minutes per exercise):
- Product list (name only) [using products_attributes hash]
- Product list (name, brand, gender, age, and price)
- Product list (name, brand, gender, age, price, and image)
- Product list (name, brand, gender, age, price, and image) [using Frontend Product Model]
- Product list (name, brand, gender, age, price, and image) [following provided HTML structure and CSS style]
- Product list pagination links [navigation via anchor links]
- Product list pagination links [following provided HTML structure and CSS style]
- Product list pagination links [navigation via Frontend rendering with Content Data-Binding and REST API calls]
- Product info (name only) [navigating via anchor link]
- Product info (name, brand, gender, age, and price)
- Product info (name, brand, gender, age, price, and image)
- Product info (name, brand, gender, age, price, image, and description)
- Product info (name, brand, gender, age, price, image, and description) [add back to products button]
- Product info (name, brand, gender, age, price, image, and description) [navigation via Frontend rendering, including link back to products]
- Product list sorting by product name
- Product list sorting by product name or price
- Product list filtering by product name
- Product list filtering by product name, brand, gender, and/or age

As extra learning homework after the workshop:
- Add product to cart (quantity of 1 and size of M by default)
- Add product to cart with specified quantity
- Add product to cart with specified quantity and size
- Display dialog for choosing whether to continue shopping or checkout cart
- Checkout cart
- Fill in Shipping Address
- Fill in Billing Address
- Fill in Payment Info
- Place order and see order invoice
- Adjust product quantity in checkout cart page
- Remove product in checkout cart page

Troubleshooting tip: During exercise work, if you ever get weird Opal errors that do not relate to the project code, stop the Rails server,
run `rm -rf tmp/cache`, and then start the rails server again with `rails s`. Afterwards, refresh the website, and the errors should go away
if they are indeed unrelated to the project code.

## TODO

+ List products
* ProductSerializer
* Pagination
- Pagination with automatic fetching of the rest of the products in the background (if a future page was loaded already, then navigating to it is instant)
* Filtering by product name (full text search) + filter component
- Filtering by brand
- Filtering by gender
- Filtering by age
- Sorting by Name: A to Z
- Sorting by Name: A to A
- Sorting by Price: Low to High
- Sorting by Price: High to Low
* Show 15 items per page
- Show 30 items per page
- Show 60 items per page

* See product (including gender and age)
+ Select product size
+ Modify quantity for adding to shopping cart
* Add to cart (with an animation [svg?] that shows the product getting added to the shopping cart icon, updating the cart item count badge)
- Show Shopping Cart icon in the top-right

* View My Cart (with items, subtotal, shipping, taxes, and total)
- Tweak quantities
- Remove items

* Checkout
* Complete Cart steps (with accordion UI): Fill in Shipping address -> Fill in Billing Address -> Fill in Payment Information -> See Order Review Page and Confirm Order

* See Order Invoice

- Styling

- Do all page transitions locally with history.pushState or by definining a route container around every component's content (e.g. /products for product_list)

Remaining backend tasks:
Important:
+ Final DB seeds with images, lorem ipsum, and better product names
- Product collection serializer including pagination information
Less Important:
- Remove items (destroy order lines)
- Change item quantity in shopping cart (update order lines)
- Address and ProductInfo validations

## License

[MIT](/LICENSE.txt)

Copyright (c) 2026 Andy Maleh

License of [images](https://publicdomainvectors.org/en/free-clipart/Green-t-shirt-vector-image/11653.html) is Public Domain Creative Commons
