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

    def getChefByID(id)
      @chef = ChefRepository.getChefByID(id)
    end

    def updateChef(chef, chef_params)
      @is_chef_update = ChefRepository.updateChef(chef, chef_params)
    end

    def updatePassword(chef, password)
      @is_update_password = ChefRepository.updatePassword(chef, password)
    end
  end
end
