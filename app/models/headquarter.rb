class Headquarter < ApplicationRecord
  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_length_of :description, maximum: 500
end
