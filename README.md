# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## TODO

+ List products
- ProductSerializer
- Pagination
- Pagination with automatic fetching of the rest of the products in the background (if a future page was loaded already, then navigating to it is instant)
- Filtering by product name (full text search) + filter component
- Filtering by brand
- Filtering by gender
- Filtering by age
- Sorting by Name: A to Z
- Sorting by Name: A to A
- Sorting by Price: Low to High
- Sorting by Price: High to Low
- Show 24 items per page
- Show 48 items per page
- Show 72 items per page
- Show all items (with infinite scroll)

- See product (including gender and age)
+ Select product size
+ Modify quantity for adding to shopping cart
- Add to cart (with an animation [svg?] that shows the product getting added to the shopping cart icon, updating the cart item count badge)
- Show Shopping Cart icon in the top-right

- View My Cart (with items, subtotal, shipping, taxes, and total)
- Tweak quantities
- Remove items

- Checkout
- Complete Cart steps (with accordion UI): Fill in Shipping address -> Fill in Billing Address -> Fill in Payment Information -> See Order Review Page and Confirm Order

- See Order Invoice

- Styling
- Final DB seeds

- Setup ActiveStorage and update clothing product images
- Do all page transitions locally with history.pushState or by definining a route container around every component's content (e.g. /products for product_list)

## Exercises

At the workshop:
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
- Product list filtering by product name and/or brand
- Product list filtering by product name, brand, and/or gender
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

## License

MIT
