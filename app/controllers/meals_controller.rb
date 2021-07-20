require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    display_meals
  end

  def add
    # have the view ask user for name
    name = @meals_view.ask_for('name')
    # have the view ask user for price
    price = @meals_view.ask_for('price').to_i
    # create an instance of a meal
    meal = Meal.new(name: name, price: price)
    # add the meal to repository
    @meal_repository.create(meal)
  end

  def edit
    display_meals
    index = @meals_view.ask_for('number').to_i - 1
    meal = @meal_repository.all[index]
    meal.name = @meals_view.ask_for('new name')
    meal.price = @meals_view.ask_for('new price').to_i
    @meal_repository.update
  end

  def destroy
    display_meals
    index = @meals_view.ask_for('number').to_i - 1
    @meal_repository.destroy(index)
  end

  private

  def display_meals
    # meals = get the meals from the repository
    meals = @meal_repository.all
    # tell the view to display the meals
    @meals_view.display(meals)
  end
end
