class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :favorite_tracks
  has_many :tracks, through: :favorite_tracks
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  def as_json(options = {})
    super(options.merge(
      include: {
        followees: { only: [:id, :name, :email] },  # Incluye los usuarios seguidos
        followers: { only: [:id, :name, :email] }  # Incluye los seguidores
      },
      except: [:created_at, :updated_at, :jti]     # Excluye campos innecesarios
    ))
  end
end
