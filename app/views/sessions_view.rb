class SessionsView < BaseView
  def welcome(employee)
    puts "Welcome #{employee.username} đ"
  end

  def wrong_credentials
    puts 'Sorry username or password was incorrect âšī¸'
  end
end
