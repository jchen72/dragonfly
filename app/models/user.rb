class User < ActiveRecord::Base

  image_accessor :avatar_image

  attr_accessible :email, :first_name, :last_name, :avatar_image, :retained_avatar_image, :remove_avatar_image

	validates :email, presence: true, uniqueness: true
	validates_presence_of :first_name
	validates_presence_of :last_name

  validates_size_of :avatar_image, maximum: 200.kilobytes

  validates_property :format, of: :avatar_image, in: [:jpeg, :png, :gif, :jpg]

  validates_property :mime_type, of: :avatar_image,
                                 in: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'],
                                 case_sensitive: false

	def name
		[first_name, last_name].join ' '
	end

end
