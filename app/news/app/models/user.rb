class User < ApplicationRecord
  
	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

    has_many :discussions, dependent: :destroy
    # Essentially creating a join table between the two tables
    has_many :topics, through: :discussions

end
