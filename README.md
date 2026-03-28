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
- Filtering by size
- Sorting by Name: A to Z
- Sorting by Name: A to A
- Sorting by Price: Low to High
- Sorting by Price: High to Low
- Show 24 items per page
- Show 48 items per page
- Show 72 items per page
- Show all items (with infinite scroll)

- See product (including gender and age)
- Select product size
- Modify quantity for adding to shopping cart
- Add to cart (with an animation [svg?] that shows the product getting added to the shopping cart icon, updating the cart item count badge)

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
