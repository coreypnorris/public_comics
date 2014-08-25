User.create(:username => "admin", :email => "admin@example.com", :password => "111111", :password_confirmation => "111111", :admin => true)
User.create(:username => "testuser", :email => "testuser@example.com", :password => "111111", :password_confirmation => "111111", :admin => false)
