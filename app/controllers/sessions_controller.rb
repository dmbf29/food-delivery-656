require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def log_in
    # username = tell the view to ask the user for username
    username = @sessions_view.ask_for('username')
    # password = tell the view to ask the user for password
    password = @sessions_view.ask_for('password')
    # employee = ask the employee repository for a employee with the username
    employee = @employee_repository.find_by_username(username)
    # check the password of the employee with the one that was given
    # if employee && employee.password == password
    if employee&.password == password
      #   "start a session" / send a welcome message
      @sessions_view.welcome(employee)
      return employee
    else
      @sessions_view.wrong_credentials
      log_in
    end
    # if the username / password is wrong
    #   send wrong credentials message
    #   make them login again
  end

  # check to see if username and password are correct
end
