# Glimmer Commerce (E-commerce Exercise Web App)
## Wroclove.rb 2026 Workshop: Building Rails SPAs in Frontend Ruby with Glimmer DSL for Web
### Author: Andy Maleh (Fukuoka 2022/2025 Winner / MS in Software Engineering)

Glimmer Commerce is a Ruby on Rails e-commerce web application that will be developed through a series of step-by-step
exercises at the Wroclove.rb 2026 Ruby Conference using [Opal Ruby](https://opalrb.com/) in the Frontend of Rails and [Glimmer DSL for Web](https://github.com/AndyObtiva/glimmer-dsl-web),
a Ruby-in-the-Browser Frontend Framework for Rails that [won a Fukuoka Prefecture Future IT Initiative 2025 award](https://andymaleh.blogspot.com/2025/01/glimmer-dsl-for-web-wins-in-fukuoka.html)
by Matz, the creator of Ruby, and other Fukuoka competition judges.

![screenshots/glimmer-commerce.png](/screenshots/glimmer-commerce.png)

Given that the Wroclove.rb event will be a workshop, we will quickly hit the ground running at the event through a series of hands-on
exercises without going through a long presentation, so it would be recommended that you familiarize yourself with
[Glimmer DSL for Web](https://github.com/AndyObtiva/glimmer-dsl-web) in advance by going through some project material on your own first:
- [Required] Fukuoka Prefecture Future IT Initiative 2025 Award Presentation Slides: https://andymaleh.blogspot.com/2025/01/glimmer-dsl-for-web-wins-in-fukuoka.html (also available [inside the GitHub repo under presentations](/presentations/Fukuoka%20Prefecture%20Future%20IT%20Initiative%202025%20-%20Glimmer%20DSL%20for%20Web%20-%20Ruby%20Web%20Frontend%20Framework%20-%20Andy%20Maleh.pdf))
- [Optional] Glimmer DSL for Web GitHub: https://github.com/AndyObtiva/glimmer-dsl-web (if possible, read through Usage, Hello World, Hello Button, Hello Observer Data-Binding, Hello Form MVP, and Hello glimmer_component Rails Helper!)
- [Optional] Frontend Ruby with Glimmer DSL for Web at Ruby on Rio 2025-06-06: https://www.youtube.com/watch?v=LY6ulYICuzE
- [Optional] Frontend Ruby with Glimmer DSL for Web at /dev/mtl 2024: https://www.youtube.com/watch?v=J2VIY9DMJo4

**The workshop does also come with presentation slides for attendees to refer to when needing help with the exercises:**
- Available online at: https://docs.google.com/presentation/d/e/2PACX-1vS-bVAY9FjCUkfDOrQ3gMX2vsNy3rAghghoX_I9O5zO3t7kukn7XFUFlmd6mQTIPFF9umvvk1WC5gAJ/pub?start=false&loop=false&delayms=60000
- Available [inside the GitHub repo under presentations](/presentations/Building%20Rails%20SPAs%20in%20Frontend%20Ruby%20with%20Glimmer%20DSL%20for%20Web%20-%20Andy%20Maleh%20-%20Wroclove.rb%202026-04-17.pdf)

## Setup Instructions

Run:
```
git clone https://github.com/AndyObtiva/glimmer_commerce.git
cd glimmer_commerce
git fetch origin
bundle
rails db:setup
rails s
```

Visit http://localhost:3000/ , click the test button, and make sure you see a message confirming test success,
to ensure Opal Ruby is working in the Frontend of the Rails web application.

(Note that the first time you load the home page, it takes a little while to load because of initial Opal Ruby to JavaScript compilation, but subsequent visits load much faster due to only compiling diffs going forward)

If you have set up the project already in advance and later discover a new version has been uploaded to the repo,
please follow these instructions to update your repo and project:

```
cd glimmer_commerce
git fetch origin
git pull
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

## Troubleshooting Tips

Although there is a chance you will not run into any trouble, it would be useful to know these troubleshooting tips
in case you run into some trouble during the exercises:
- When running into Opal Ruby errors, there are 2 classes of errors:
  - Compilation Errors: Errors that show a Rails error page with a stack trace, which happen during Opal compilation of Ruby code (e.g. missing `end` for a method or a block, bad random characters in the file, etc...). These errors can be seen in full detail in the Rails server log in the command line. So, make sure to check there if you get a Rails error page.
  - Execution Errors: Errors that happen in the Browser upon executing JavaScript compiled from Ruby. The webpage does load up, but the Frontend behavior is broken in those cases (e.g. no elements are displapyed, some element is missing, or some button does not function, etc...). These errors can be seen in full detail in the Browser Console, but do not attempt to read the class name reponsible in the printed stack trace. Instead, press on the expand arrow to open the Ruby source map stack trace below, and then search from top to bottom for the first Opal Ruby file name that appears related to your work, and look at what line number the error is referring to. You can even click on the file name and see Ruby code in the Browser directly if you want.
- During exercise work, if you ever get weird Opal errors that do not relate to the project code, stop the Rails server,
run `rm -rf tmp/cache`, and then start the rails server again with `rails s`. Afterwards, refresh the website, and the errors should go away
if they are indeed unrelated to the project code.
- If the Rails server ever gets stuck (e.g. `SystemStackError: stack level too deep`), run `ps`, find the Rails server process number,
and then run `kill -9 rails_server_process_number`.

## Exercises

(solved in the `solution` branch and in `exercise-*` branches)

These exercises will build a Rails e-commerce web app with Frontend Ruby using Glimmer DSL for Web and Opal (Ruby-to-JavaScript Transpiler).

Every exercise includes:
- Feature: the feature being developed.
- Topics: what topics in Glimmer DSL for Web you are learning through the exercise.
- Usecase: what is required by the solution from the user point of view.
- Tips: helpful tips to help figure out the solution.
- Steps: what steps to follow to do the exercise.
- Solution: the code of all the files that needed changes to solve the exercise.

You can follow the steps of exercise solutions right away, especially when getting started with the workshop, but later on, you could optionally challenge yourself and attempt to solve some exercises on your own without looking at their solution right away.

### Exercise 1 List Products (Names Only)

[docs/exercises/exercise-01-list-products-names-only.md](/docs/exercises/exercise-01-list-products-names-only.md)

### Exercise 2 List Products (Name, Brand, Gender, Age, and Price)

[docs/exercises/exercise-02-list-products-name-brand-gender-age-price.md](/docs/exercises/exercise-02-list-products-name-brand-gender-age-price.md)

### Exercise 3 List Products (Name, Brand, Gender, Age, Price, and Image)

[docs/exercises/exercise-03-list-products-name-brand-gender-age-price-image.md](/docs/exercises/exercise-03-list-products-name-brand-gender-age-price-image.md)

### Exercise 4 List Products (Refactor)

[docs/exercises/exercise-04-list-products-refactor.md](/docs/exercises/exercise-04-list-products-refactor.md)

### Exercise 5 List Products (Style)

[docs/exercises/exercise-05-list-products-style.md](/docs/exercises/exercise-05-list-products-style.md)

### Exercise 6 Show Product Info (Name Only)

[docs/exercises/exercise-06-show-product-info-name-only.md](/docs/exercises/exercise-06-show-product-info-name-only.md)

### Exercise 7 Show Product Info (Name, Brand, Gender, Age, Price, Image, and Description)

[docs/exercises/exercise-07-show-product-info-name-brand-gender-age-price-image-description.md](/docs/exercises/exercise-07-show-product-info-name-brand-gender-age-price-image-description.md)

### Exercise 8 Show Product Info (Instant Frontend Rendering)

[docs/exercises/exercise-08-show-product-info-instant-frontend-rendering.md](/docs/exercises/exercise-08-show-product-info-instant-frontend-rendering.md)

### Exercise 9 Filter Products By Name

[docs/exercises/exercise-09-filter-products-by-name.md](/docs/exercises/exercise-09-filter-products-by-name.md)

### Exercise 10 Sort Products

[docs/exercises/exercise-10-sort-products.md](/docs/exercises/exercise-10-sort-products.md)

### Exercise 11 Paginate Products

[docs/exercises/exercise-11-paginate-products.md](/docs/exercises/exercise-11-paginate-products.md)

## Homework After The Workshop

(solved partially in the `proof-of-concept` branch)

After the workshop is done, you could implement these exercises on your own to improve your skills further in Glimmer DSL for Web:
- Filter products by brand, age, and/or gender.
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

## License

[MIT](/LICENSE.txt)

Copyright (c) 2026 Andy Maleh

License of [images](https://publicdomainvectors.org/en/free-clipart/Green-t-shirt-vector-image/11653.html) is Public Domain Creative Commons
