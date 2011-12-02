User.create email: 'dev@toupoutou.fr', :password => 'toupoutou'

a = User.create :email => "tou@poutou.pou", :password => "password", :first_name => "Tou", :last_name => "Poutou", :birthday => Date.parse("12/12/2000")
a.friends.create :email => "test@test.com", :password => "password", :first_name => "Leo", :last_name => "Unbekandt", :birthday => Date.parse("9/12/1992")
a.friends.create :email => "test2@test.com", :password => "password", :first_name => "Lucas", :last_name => "Bee", :birthday => Date.parse("4/12/1004")
a.friends.create :email => "test3@test.com", :password => "password", :first_name => "Victor", :last_name => "Bahl", :birthday => Date.parse("8/12/1004")
a.friends.create :email => "test4@test.com", :password => "password", :first_name => "Paul", :last_name => "Chobert", :birthday => Date.parse("15/12/1004")

