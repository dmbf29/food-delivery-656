class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    puts "Welcome to the LW Kitchen!"
    puts "           --           "

    while @running
      @current_user = @sessions_controller.log_in
      while @current_user
        if @current_user.manager?
          display_manager_tasks # change to manager tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          display_rider_tasks # change to rider tasks
          action = gets.chomp.to_i
          print `clear`
          route_rider_action(action)
        end
      end
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.create
    when 0 then log_out
    when 10 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 0"
    end
  end

  def route_rider_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 0 then log_out
    when 10 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 0"
    end
  end

  def log_out
    @current_user = nil
  end

  def stop
    log_out
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "5 - List all the undelivered orders"
    puts "6 - Create a new order"
    puts "0 - Log out"
    puts "10 - Stop and exit the program"
  end

  def display_rider_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all my undelivered orders"
    puts "2 - Mark one of my orders as delivered"
    puts "0 - Log out"
    puts "10 - Stop and exit the program"
  end
end


