class WaiterRepository
  class << self

    # create waiter
    def create_waiter(waiter)
      @is_waiter_create = waiter.save
    end

    # find waiter using email
    def find_by_email(email)
      @waiter = Waiter.find_by(email: email)
    end

    #get waiter Id
    def get_waiter_by_id(id)
      @waiter = Waiter.find(id)
    end

    #update waiter profile
    def update_waiter(waiter, waiter_params)
      @is_update_waiter = waiter.update(waiter_params)
    end

    #update waiter password
    def update_password(waiter, password)
      @is_update_password = waiter.update_attribute(:password, password)
    end

    def create_order(waiter, status, total_price)
      @order = waiter.orders.create(status: status, total_price: total_price)
    end

    def create_order_items(waiter_order, items)
      @order_items = waiter_order.order_items.create(items)
    end
  end
end
