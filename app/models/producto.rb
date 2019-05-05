class Producto < ApplicationRecord
  has_many :categorium, :dependent => :destroy
  validates :nombre, :precio, :categoria_id, presence: true
  validates :nombre, length: { in: 6..20 }
end
