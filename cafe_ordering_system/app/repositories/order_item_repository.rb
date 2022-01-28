class OrderItemRepository
  class << self
    def get_orders
      @orders = Order.all.select { |order| order.status != "finished" }
    end
  end
end
