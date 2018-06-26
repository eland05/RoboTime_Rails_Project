class Team < ApplicationRecord
  belongs_to :user
  has_many :team_members
  has_many :users, through: :team_members
  accepts_nested_attributes_for :team_members, allow_destroy: true

end
