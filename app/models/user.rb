class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	has_many :wishlistItems
  field :facebook_id, :type => Integer
  field :birthday, :type => Date
  field :avatar
  field :interests, :type => String
  field :facebook_access_token

  def name
    "#{first_name} #{last_name}"
  end

  field :facebook_id, :type => Integer
  field :birthday, :type => Date
  
  has_and_belongs_to_many :friends, :class_name => 'User', :autosave => true, :inverse_of => :friends_of
  has_and_belongs_to_many :friends_of, :class_name => 'User', :autosave => true, :inverse_of => :friends
  has_and_belongs_to_many :facebook_friends, :class_name => 'User', :autosave => true, :inverse_of => :facebook_friends_of
  has_and_belongs_to_many :facebook_friends_of, :class_name => 'User', :autosave => true, :inverse_of => :facebook_friends
  has_and_belongs_to_many :musics
  has_and_belongs_to_many :films

  @queue = :toupoutou_users

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['raw_info']
    if user = User.where(:email => data["email"]).first
      user.update_attribute :facebook_access_token, access_token['credentials']['token']
      user
    else # Create a user with a stub password.
      password = Devise.friendly_token[0,20]
      user = User.create(:email => data["email"], :facebook_id => data['id'], :facebook_access_token => access_token['credentials']['token'], :password => password, :password_confirmation => password, :first_name  => data.first_name, :last_name => data.last_name)
      user.async(:load_friends)
      user.async(:load_musics)
      user.async(:load_films)
      # load_films
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

  def load_musics
    @api = Koala::Facebook::API.new(self.facebook_access_token)
    musics = @api.get_connections(self.facebook_id, 'music')
    musics.each do |music_attrs|
      if music = Music.where(:facebook_id => music_attrs['id']).first
        self.musics << music
      else
        self.musics.create :name => music_attrs['name'], :facebook_id => music_attrs['id']
      end
    end
  end

  def load_films
    @api = Koala::Facebook::API.new(self.facebook_access_token)
    films = @api.get_connections(self.facebook_id, 'movies')
    films.each do |films_attrs|
      if music = Film.where(:facebook_id => films_attrs['id']).first
        self.films << music
      else
        self.films.create :name => films_attrs['name'], :facebook_id => films_attrs['id']
      end
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
      user = self.facebook_friends.create(:email => "#{friend_data['username']}@facebook.com", :facebook_id => friend_data['id'], :password => password, :password_confirmation => password, :first_name  => friend_data['first_name'], :last_name => friend_data['last_name'])
      user.async(:load_musics)
      user.async(:load_films)
    end
  end
end

