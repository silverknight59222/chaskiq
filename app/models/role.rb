class Role < ApplicationRecord
  belongs_to :agent
  belongs_to :app

  scope :admin , ->{where("role =?", "admin")}
end
