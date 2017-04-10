class Map < ActiveRecord::Base

	belongs_to :user
	
	scope :public_maps, lambda { where(is_public: true) }
	
end
