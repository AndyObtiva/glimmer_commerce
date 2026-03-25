class OrderLineSerializer < ActiveModel::Serializer
  attributes :product, :size, :quantity

  def product
    ProductSerializer.new(object.product).serializable_hash
  end
end
