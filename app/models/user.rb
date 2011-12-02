class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	has_many :wishlistItems
  field :facebook_id, :type => Integer
  field :birthday, :type => Date

  has_and_belongs_to_many :friends, :class_name => "User"
  has_and_belongs_to_many :facebook_friends, :class_name => 'User'

  field :facebook_id, :type => Integer
  field :birthday, :type => Date
  
  @queue = :toupoutou_users

  has_and_belongs_to_many :friends, :class_name => "User"

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['raw_info']
    if user = User.where(:email => data["email"]).first
      user.update_attribute :facebook_access_token, access_token['credentials']['token']
      user
    else # Create a user with a stub password.
      password = Devise.friendly_token[0,20]
      user = User.create(:email => data["email"], :facebook_id => data['id'], :facebook_access_token => access_token['credentials']['token'], :password => password, :password_confirmation => password, :first_name  => data.first_name, :last_name => data.last_name)
      user.async(:load_friends)
      user
    end
  end

  def self.perform(id, method, *args)
    find(id).send(method, *args)
  end

  def async(method, *args)
    Resque.enqueue(User, id, method, *args)
  end

  def load_friends
    @api = Koala::Facebook::API.new(self.facebook_access_token)
    friends = @api.get_connections('me', 'friends')
    friends.each do |friend_attrs|
      async(:load_friend, friend_attrs['id'])
    end
  end

  def load_friend(friend_id)
    @api = Koala::Facebook::API.new(self.facebook_access_token)
    friend_data = @api.get_object(friend_id)
    if friend = User.where(:facebook_id => friend_data['id']).first
      self.facebook_friends << friend
      self.save
    else
      password = Devise.friendly_token[0,20]
      self.facebook_friends.create(:email => "#{friend_data['username']}@facebook.com", :facebook_id => friend_data['id'], :password => password, :password_confirmation => password, :first_name  => friend_data['first_name'], :last_name => friend_data['last_name'])
    end
  end
end

