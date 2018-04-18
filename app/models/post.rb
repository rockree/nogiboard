class Post < ApplicationRecord
  validates :user_id,{presence: true}
  validates :content,{presence: true}

  belongs_to :user
  has_many :likes, dependent: :destroy
end
