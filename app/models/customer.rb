class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :province
  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "id", "id_value", "name", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  validates :name, presence: true
  validates :address, presence: true
  validates :province_id, presence: true
end