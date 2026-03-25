# Glimmer Commerce
## Rails Web App for Building Rails SPAs in Frontend Ruby with Glimmer DSL for Web at Wroclove.rb Ruby Conference 2026

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
git db:reset
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

Troubleshooting tip: During exercise work, if you ever get weird Opal errors that do not relate to the project code, stop the Rails server,
run `rm -rf tmp/cache`, and then start the rails server again with `rails s`. Afterwards, refresh the website, and the errors should go away
if they are indeed unrelated to the project code.

## License

[MIT](/LICENSE.txt)

Copyright (c) 2026 Andy Maleh
