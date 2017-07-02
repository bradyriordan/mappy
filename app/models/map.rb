class Map < ActiveRecord::Base

	belongs_to :user
	
	scope :public_maps, lambda { where(is_public: true) }

	def self.search(search)
	  
	  where("LOWER(name) LIKE ? OR user_id LIKE ?", "%#{search}%", "%#{search}%")
	end	
		
end
