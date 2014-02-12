class Post < ActiveRecord::Base
  translates :title, :body
	 belongs_to :author, class_name: "User"
	 has_many :comments, as: :commentable


  def self.published
    where(published: true)
  end

	def publish!
  	published = true
  	save!
	end
end
