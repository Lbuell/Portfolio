class Post < ActiveRecord::Base
	 belongs_to :author, class_name: "User"


  def self.published
    where(published: true)
  end

	def publish!
  	published = true
  	save!
	end
end
