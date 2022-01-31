class OrderItemService
  class << self
    def get_orders
      @orders = OrderItemRepository.get_orders
    end
  end
end
