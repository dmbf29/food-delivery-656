class Employee
  attr_accessor :id
  attr_reader :username, :password, :role

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @username = attributes[:username] # string
    @password = attributes[:password] # string
    @role = attributes[:role] # string
  end

  def manager?
    role == 'manager'
  end

  def rider?
    !manager?
  end

  # Not saving to the CSV
  # def self.headers
  #   ['id', 'username', 'password']
  # end

  # def build_row
  #   [@id, @username, @password]
  # end
end
