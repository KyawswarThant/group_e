class ChefService
  class << self
    
    # create chef
    def create_chef(chef)
        @is_chef_create = ChefRepository.create_chef(chef)
    end
   
    # find chef using email
    def find_by_email(email)
        @chef = ChefRepository.find_by_email(email)
    end

  end
end