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

    def getWaiterByID(id)
      @waiter = WaiterRepository.getWaiterByID(id)
    end

    def updateWaiter(waiter, waiter_params)
      @is_waiter_update = WaiterRepository.updateWaiter(waiter, waiter_params)
    end

    def updatePassword(waiter, password)
      @is_update_password = WaiterRepository.updatePassword(waiter, password)
    end
  end
end
