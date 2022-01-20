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

    def getWaiterByID(id)
      @waiter = Waiter.find(id)
    end

    def updateWaiter(waiter, waiter_params)
      @is_update_waiter = waiter.update(waiter_params)
    end

    def updatePassword(waiter, password)
      @is_update_password = waiter.update_attribute(:password, password)
    end
  end
end
