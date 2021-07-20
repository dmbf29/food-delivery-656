require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal) # instance
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << Meal.headers
      @meals.each do |meal|
        # csv << [meal.id, meal.name, meal.price]
        csv << meal.build_row
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # update any value from a string to something else
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.any? ? @meals.last.id + 1 : 1
  end
end
