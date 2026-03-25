180.times do |n|
  product_number = n + 1
  Product.find_or_create_by!(name: "T-Shirt #{product_number}") do |product|
    product.brand = "Brand #{(product_number % 10) + 1}"
    product.gender = Product::GENDERS.sample
    product.age = Product::AGES.sample
    product.description = "Lorem ipsum #{product_number} dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    product.price = rand(10_000) / 100.0
  end
end
