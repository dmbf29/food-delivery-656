require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @orders = []
    @next_id = 1
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def create(order) # instance
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select { |order| order.employee == employee }
  end

  def update
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << Order.headers
      @orders.each do |order|
        # csv << [order.id, order.name, order.price]
        csv << order.build_row
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      #<CSV::Row id:1 meal_id:"2" customer_id:"1" employee_id:"2" delivered:"false">
      #<CSV::Row id:2 meal_id:"1" customer_id:"1" employee_id:"3" delivered:"false">
      row[:id] = row[:id].to_i
      meal_id = row[:meal_id].to_i
      meal = @meal_repository.find(meal_id)
      row[:meal] = meal
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:delivered] = row[:delivered] == 'true'
      @orders << Order.new(row)
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end
end
