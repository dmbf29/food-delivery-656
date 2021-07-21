require_relative 'base_view'

class OrdersView < BaseView
  def display(orders) # an array of instances
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1}. #{order.meal.name}
        Customer: #{order.customer.name} - #{order.customer.address} - Driver: #{order.employee.username}"
      end
    else
      puts "No orders yet ☹️"
    end
  end
end
