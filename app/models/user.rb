class User < ActiveRecord::Base
  
  has_secure_password

  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => true
  validates :password, :presence => true,
                       :on => :create,
                       :length => {:minimum => 5, :maximum => 40},
                       :confirmation => true
end
