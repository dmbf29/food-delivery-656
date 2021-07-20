class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    puts "Welcome to the LW Kitchen!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @meals_controller.edit
    when 4 then @meals_controller.destroy
    when 5 then @customers_controller.list
    when 6 then @customers_controller.add
    when 7 then @customers_controller.edit
    when 8 then @customers_controller.destroy
    when 0 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 0"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    display_meal_tasks
    display_customer_tasks
    puts "0 - Stop and exit the program"
  end

  def display_meal_tasks
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - Edit a meal"
    puts "4 - Remove a meal"
  end

  def display_customer_tasks
    puts "5 - List all customers"
    puts "6 - Create a new customer"
    puts "7 - Edit a customer"
    puts "8 - Remove a customer"
  end
end
