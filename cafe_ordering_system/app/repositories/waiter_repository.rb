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

  end
end