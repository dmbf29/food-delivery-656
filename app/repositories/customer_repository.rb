require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer) # instance
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << Customer.headers
      @customers.each do |customer|
        # csv << [customer.id, customer.name, customer.price]
        csv << customer.build_row
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # update any value from a string to something else
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    @next_id = @customers.any? ? @customers.last.id + 1 : 1
  end
end
