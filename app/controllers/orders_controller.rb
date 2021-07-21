require_relative '../models/order'
require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def list_undelivered_orders
    display_orders
  end

  def create
    # display the meals to the user
    # get the meals from the meal repo
    # give those meals to the view
    # ask the user for a meal index
    # meal = user the index for the meals array
    meal = build_meal
    customer = build_customer
    employee = build_employee

    # create an instance of an order
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # give the order to the repo
    @order_repository.create(order)
  end

  def list_my_orders(employee)
    @order_repository.all
    # get my orders from the repo
    orders = @order_repository.my_undelivered_orders(employee)
    # give them to the view
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
    # ask user for index of the order to 'deliver'
    index = @orders_view.ask_for('number').to_i - 1
    # get the order from the orders array
    order = orders[index]
    # mark an order as deliver!
    order.deliver!
    # save the orders in the csv
    @order_repository.update
  end

  private

  def display_orders
    # get the undelivered orders from the repo
    orders = @order_repository.undelivered_orders
    # give the to the view
    @orders_view.display(orders)
  end

  def build_meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    meal_index = @meals_view.ask_for('number').to_i - 1
    return meals[meal_index]
  end

  def build_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    customer_index = @customers_view.ask_for('number').to_i - 1
    return customers[customer_index]
  end

  def build_employee
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    employee_index = @employees_view.ask_for('number').to_i - 1
    return employees[employee_index]
  end

end
