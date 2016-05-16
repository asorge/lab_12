class User < ActiveRecord::Base
	has_secure_password

	# Rels
	belongs_to :band

	# Validations
	validates_presence_of :first_name, :last_name, :password_digest
	validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"
	validates_inclusion_of :role, in: %w[member manager admin], message: "is not an option for role"
	

	# Methods
	def proper_name
		"#{first_name} #{last_name}"
	end
	
	ROLES = [['Administrator', :admin],['Band Manager', :manager],['Band Member', :member]]

	  def role?(authorized_role)
	    return false if role.nil?
	    role.to_sym == authorized_role
	  end

	def self.authenticate(email,password)
    	find_by_email(email).try(:authenticate, password)
  	end
end


