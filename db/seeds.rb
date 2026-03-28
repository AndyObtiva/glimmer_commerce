100.times do |n|
  product_number = n + 1
  Product.find_or_create_by!(name: "Product #{product_number}") do |product|
    product.brand = "Brand #{(product_number % 10) + 1}"
    product.gender = Product::GENDERS.sample
    product.age = Product::AGES.sample
    product.description = "<p>Product #{product_number} is a useful product!<br>It is high quality and durable.</p>"
    product.price = rand(10_000) / 100.0
  end
end
