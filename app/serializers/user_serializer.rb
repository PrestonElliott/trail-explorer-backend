class UserSerializer < ActiveModel::Serializer
  has_many :trips
  has_many :future_trips

  attributes :id, :email, :name, :profile_picture, :followed_users

  def followed_users
  	user_hash = {}

    self.object.followed_users.map do |f|
    	user_hash[f.id] = FollowedUserSerializer.new(f);
    end
    return user_hash
  end
end
