class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable, :omniauth_providers => [:facebook]

  validates_presence_of :email, if: :is_not_from_host?, message: 'Емаилот не може да биде празен'
  validates_presence_of :password,if: :is_not_from_host?, message: 'Лозинката не може да биде празна'
  validates_presence_of :name, if: :is_not_from_host?, message: 'Името и Презимето не мозат да бидат празни'


  def exists_with_email?
    User.exists?(email: email)
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
    end
  end

  def is_not_from_host?
    !provider.present?
  end
end
