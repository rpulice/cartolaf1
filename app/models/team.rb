class Team < ApplicationRecord
	validates :nome, presence: true
  has_many :team_players
  accepts_nested_attributes_for :team_players, reject_if: :all_blank, allow_destroy: true
end
