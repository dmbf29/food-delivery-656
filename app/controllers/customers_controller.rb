require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    display_customers
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

  def edit
    display_customers
    index = @customers_view.ask_for('number').to_i - 1
    customer = @customer_repository.all[index]
    customer.name = @customers_view.ask_for('new name')
    customer.address = @customers_view.ask_for('new address')
    @customer_repository.update
  end

  def destroy
    display_customers
    index = @customers_view.ask_for('number').to_i - 1
    @customer_repository.destroy(index)
  end

  private

  def display_customers
    # customers = get the customers from the repository
    customers = @customer_repository.all
    # tell the view to display the customers
    @customers_view.display(customers)
  end
end
