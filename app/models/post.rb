class Post < ApplicationRecord
  validates :user_id,{presence: true}
  validates :content,{presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
