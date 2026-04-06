product_number = 0
product_color_to_image_mappings = Dir.glob(Rails.root.join('public', 'images', 't-shirts', '**', '*')).map {|path| [path.split('/').last.split('.').first.match(/t-shirt-(.*)/)[1].split('-').map(&:capitalize).join(' '), path.sub("#{Rails.root.to_s}/public",'')] }.to_h
products_attributes = []
product_color_to_image_mappings.each do |color, image_path|
  Product::BRANDS.each do |brand|
    Product::GENDERS.each do |gender|
      Product::AGES.each do |age|
        product_number += 1
        name = "T-Shirt #{product_number.to_s.rjust(3, '0')} #{color}"
        description = "#{name} Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        price = (rand(10_000) / 100.0).round(2)
        products_attributes << {name:, brand:, gender:, age:, description:, price:, image_path:}
      end
    end
  end
end
products_attributes.shuffle.each do |product_attributes|
  Product.find_or_create_by!(name: product_attributes[:name]) do |product|
    product.assign_attributes(product_attributes)
  end
end
