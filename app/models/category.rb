class Category < ActiveRecord::Base
	validates :name, presence:true, length:{ minimum:3, maximum:50 }
end
