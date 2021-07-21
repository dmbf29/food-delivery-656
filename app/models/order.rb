class Order
  attr_accessor :id
  attr_reader :meal, :employee, :customer

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # meal
    @customer = attributes[:customer] # customer
    @employee = attributes[:employee] # employee
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def self.headers
    ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
  end

  def build_row
    [@id, @meal.id, @customer.id, @employee.id, @delivered]
  end
end
