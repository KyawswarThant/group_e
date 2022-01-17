class ChefRepository
  class << self
  
    # create chef
    def create_chef(chef)
      @is_chef_create = chef.save
    end
 
    # find chef using email
    def find_by_email(email)
        @chef = Chef.find_by(email: email)
    end

  end
end