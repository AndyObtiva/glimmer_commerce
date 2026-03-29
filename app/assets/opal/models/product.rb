Product = Struct.new(:id, :name, :description, :price, :brand, :gender, :age, :created_at, :updated_at, :resource_path, keyword_init: true) do
  self::SIZES = %w[XS S M L XL XXL XXXL]
end
