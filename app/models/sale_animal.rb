class SaleAnimal < ApplicationRecord
  belongs_to :sale
  belongs_to :animal

  validates :animal_id, uniqueness: { scope: :sale_id }
end
