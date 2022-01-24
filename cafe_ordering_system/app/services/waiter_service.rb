class WaiterService
  class << self

    # create waiter
    def create_waiter(waiter)
      @is_waiter_create = WaiterRepository.create_waiter(waiter)
    end

    # find waiter using email
    def find_by_email(email)
      @waiter = WaiterRepository.find_by_email(email)
    end

    #get waiter Id
    def get_waiter_by_id(id)
      @waiter = WaiterRepository.get_waiter_by_id(id)
    end

    #update waiter profile
    def update_waiter(waiter, waiter_params)
      @is_waiter_update = WaiterRepository.update_waiter(waiter, waiter_params)
    end

    #update waiter password
    def update_password(waiter, password)
      @is_update_password = WaiterRepository.update_password(waiter, password)
    end
  end
end
