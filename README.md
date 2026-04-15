# Glimmer Commerce (E-commerce Exercise Web App)
## Wroclove.rb 2026 Workshop: Building Rails SPAs in Frontend Ruby with Glimmer DSL for Web
### Author: Andy Maleh (Fukuoka 2022/2025 Winner / MS in Software Engineering)

Glimmer Commerce is a Ruby on Rails e-commerce web application that will be developed through a series of step-by-step
exercises at the Wroclove.rb 2026 Ruby Conference using [Opal Ruby](https://opalrb.com/) in the Frontend of Rails and [Glimmer DSL for Web](https://github.com/AndyObtiva/glimmer-dsl-web),
a Ruby-in-the-Browser Frontend Framework for Rails that [won a Fukuoka Prefecture Future IT Initiative 2025 award](https://andymaleh.blogspot.com/2025/01/glimmer-dsl-for-web-wins-in-fukuoka.html)
by Matz, the creator of Ruby, and other Fukuoka competition judges.

**[IMPORTANT]** Please make sure to set up this project on your machine ahead of the conference workshop, as per the setup instructions below, as there is
no guarantee that there would be Internet at the event. That has to be done after April 15, 2026 00:00 Eastern Time (06:00 in Wroclaw, Poland) to pull the
most up-to-date version of this project's code before the workshop takes place on April 17, 2026 at 14:00. There will be a USB thumb drive at the event just in case some attendees drop in without having pre-downloaded the GitHub repo,
but it would still be better for others to set up the repo ahead of the event.

![screenshots/glimmer-commerce.png](/screenshots/glimmer-commerce.png)

Given that the Wroclove.rb event will be a workshop, we will quickly hit the ground running at the event through a series of hands-on
exercises without going through a long presentation, so it would be recommended that you familiarize yourself with
[Glimmer DSL for Web](https://github.com/AndyObtiva/glimmer-dsl-web) in advance by going through some project material on your own first:
- [Required] Fukuoka Prefecture Future IT Initiative 2025 Award Presentation Slides: https://andymaleh.blogspot.com/2025/01/glimmer-dsl-for-web-wins-in-fukuoka.html (also available [inside the GitHub repo under presentations](/presentations/Fukuoka%20Prefecture%20Future%20IT%20Initiative%202025%20-%20Glimmer%20DSL%20for%20Web%20-%20Ruby%20Web%20Frontend%20Framework%20-%20Andy%20Maleh.pdf))
- [Optional] Glimmer DSL for Web GitHub: https://github.com/AndyObtiva/glimmer-dsl-web (if possible, read through Usage, Hello World, Hello Button, Hello Observer Data-Binding, Hello Form MVP, and Hello glimmer_component Rails Helper!)
- [Optional] Frontend Ruby with Glimmer DSL for Web at Ruby on Rio 2025-06-06: https://www.youtube.com/watch?v=LY6ulYICuzE
- [Optional] Frontend Ruby with Glimmer DSL for Web at /dev/mtl 2024: https://www.youtube.com/watch?v=J2VIY9DMJo4

## Setup Instructions

**[IMPORTANT]** The repo must be pulled after April 15, 2026 00:00 Eastern Time (06:00 in Wroclaw, Poland) to ensure having
the most up to date code that is required for the workshop as there is no guarantee that there would be Internet at the event.
There will be USB thumb drives at the event just in case some attendees drop in without having pre-downloaded the GitHub repo,
but it would still be better for others to set up the repo ahead of the event.

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

**[IMPORTANT]** If you have set up the project already in advance and later discover a new version has been uploaded to the repo,
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

(solved in the `solution` branch)

These exercises will build a Rails e-commerce web app with Frontend Ruby using Glimmer DSL for Web and Opal (Ruby-to-JavaScript Transpiler).

Every exercise includes:
- Feature: the feature being developed.
- Topics: what topics in Glimmer DSL for Web you are learning through the exercise.
- Usecase: what is required by the solution from the user point of view.
- Tips: helpful tips to help figure out the solution.
- Steps: what steps to follow to do the exercise.
- Solution: the code of all the files that needed changes to solve the exercise.

You can follow the steps of exercise solutions right away, especially when getting started with the workshop, but later on, you could optionally challenge yourself and attempt to solve some exercises on your own without looking at their solution right away.

Exercise list (about 10 minutes per exercise):
- Hello Data Binding
- Product list (name only) [using products_attributes hash]
- Product list (name, brand, gender, age, and price)
- Product list (name, brand, gender, age, price, and image)
- Product list (name, brand, gender, age, price, and image) [using Frontend Product Model]
- Product list (name, brand, gender, age, price, and image) [following provided HTML structure and CSS style]
- Product info (name only) [navigating via anchor link]
- Product info (name, brand, gender, age, price, description, and image)
- Product info (name, brand, gender, age, price, description, and image) [Frontend navigation via component page link]
- Product info (name, brand, gender, age, price, description, and image) [add back to products component page link]
- Product list filtering by product name (implement with content-data-binding and Rails::ResourceService)
- Product list sorting by id, name, or price (implement with content-data-binding and Rails::ResourceService)
- Product list pagination links [implement with content-data-binding and Rails::ResourceService, following provided HTML structure and CSS style]

## Homework After The Workshop

(solved in the `solution` branch)

After the workshop is done, you could implement these exercises on your own to improve your skills further in Glimmer DSL for Web:
- Filter Products by product brand, gender, and/or age using the `multi_checkbox_dropdown` custom component from the `glimmer-web-components` gem
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
