User.create(:username => "admin", :email => "admin@example.com", :password => "11111111", :password_confirmation => "11111111", :admin => true)
User.create(:username => "testuser", :email => "testuser@example.com", :password => "11111111", :password_confirmation => "11111111", :admin => false)
