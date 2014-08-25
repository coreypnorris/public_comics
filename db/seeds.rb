User.create(:username => "admin", :email => "admin@example.com", :password => ENV['ADMIN_PASSWORD'], :password_confirmation => ENV['ADMIN_PASSWORD'], :admin => true)
User.create(:username => "testuser", :email => "testuser@example.com", :password => ENV['TEST_USER_PASSWORD'], :password_confirmation => ENV['TEST_USER_PASSWORD'], :admin => false)
