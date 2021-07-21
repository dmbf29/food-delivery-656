class SessionsView < BaseView
  def welcome(employee)
    puts "Welcome #{employee.username} 👋"
  end

  def wrong_credentials
    puts 'Sorry username or password was incorrect ☹️'
  end
end
