class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :state
  belongs_to :delivery_charge
  belongs_to :delivery_method
  belongs_to :delivery_area
  belongs_to :delivery_date
  belongs_to :user
  belongs_to :status

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  mount_uploader :image, ImageUploader

  validates :image, :name, :description, :category_id, :state_id, :delivery_charge_id, :delivery_method_id, :delivery_area_id, :delivery_date_id, :price, presence: true

  def self.search(search)
    return Product.all unless search
    Product.where(['name LIKE ?', "%#{search}%"]).where.not(status_id: 3).order('created_at DESC')
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

end
