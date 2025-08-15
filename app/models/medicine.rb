class Medicine < ApplicationRecord
  self.inheritance_column = 'not_a_type'
end
