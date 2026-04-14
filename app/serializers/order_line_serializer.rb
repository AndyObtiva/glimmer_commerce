class OrderLineSerializer < ActiveModel::Serializer
  attributes :id, :product, :size, :quantity

  def product
    ProductSerializer.new(object.product).serializable_hash
  end
end
