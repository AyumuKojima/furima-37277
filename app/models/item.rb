class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery
  belongs_to :prefecture
  belongs_to :send_day

  validate :image_attached

  with_options presence: true do
    validates :item_name
    validates :info
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid" }
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :delivery_id
    validates :prefecture_id
    validates :send_day_id
  end

  private

  def image_attached
    if !image.attached?
      errors.add(:image, "can't be blank")
    end
  end
end
