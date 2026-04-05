# TODO make sure to seed product images (maybe selecting random images from a directory per gender/age combo) or maybe just use generic blank colored t-shirts for all genders/ages
# and see if we can use Faker to generate better product names or maybe keep numbers in names to be able to test pagination correctly
180.times do |n|
  product_number = n + 1
  Product.find_or_create_by!(name: "Product #{product_number}") do |product|
    product.brand = "Brand #{(product_number % 10) + 1}"
    product.gender = Product::GENDERS.sample
    product.age = Product::AGES.sample
    product.description = "<p>Product #{product_number} is a useful product!<br>It is high quality and durable.</p>"
    product.price = rand(10_000) / 100.0
  end
end
