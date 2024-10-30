class Character < ApplicationRecord
  UNITS_TO_TEAMS = {
    mage: 1,
    knight: 1,
    medusa: 2,
    jinn: 2
  }.freeze

  ACCEPTABLE_UNITS = %w[mage knight medusa jihn].freeze

  # позволяет задать команду автоматически, если она не указана, еще до валидации.
  before_validation :assign_team
  #требует, чтобы атрибут team не был пустым
  validates :team, presence: true
  #требует, чтобы атрибут unit не был пустым
  validates :unit, presence: true
  #проверяет, что атрибут unit имеет одно из значений: mage, knight, medusa, jinn
  validates :unit, acceptance: { accept: ACCEPTABLE_UNITS }
  validate :correct_team?

  private
  #проверяет, соответствует ли team правильной команде для данного unit
  def correct_team?
    errors.add(:unit, "У юнита #{unit} некорректный номер команды #{team}") unless UNITS_TO_TEAMS[unit.to_sym] == team
  end
  # устанавливает team, если оно еще не задано
  # используя значение из characters на основе значения unit.
  def assign_team
    self.team = UNITS_TO_TEAMS[unit.to_sym] if team.nil?
  end
end