require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # customers = get the customers from the repository
    customers = @customer_repository.all
    # tell the view to display the customers
    @customers_view.display(customers)
  end

  def add
    # have the view ask user for name
    name = @customers_view.ask_for('name')
    # have the view ask user for price
    address = @customers_view.ask_for('address')
    # create an instance of a customer
    customer = Customer.new(name: name, address: address)
    # add the customer to repository
    @customer_repository.create(customer)
  end
end
