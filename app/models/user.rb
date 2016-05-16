class User < ActiveRecord::Base
	has_secure_password

	# Rels
	belongs_to :band

	# Validations
	validates_presence_of :first_name, :last_name, :password_digest
	validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"
	validates_inclusion_of :role, in: %w[member manager], message: "is not an option for role"
	validates_numericality_of :band_id

	# Methods
	def name
		"#{first_name} #{last_name}"
	end

	def self.authenticate(email,password)
    	find_by_email(email).try(:authenticate, password)
  	end
end


