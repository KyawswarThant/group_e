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

  end
end