class Character < ApplicationRecord
  CHARACTERS = {
    mage: 1,
    knight: 1,
    medusa: 2,
    jinn: 2
  }.freeze

  # позволяет задать команду автоматически, если она не указана, еще до валидации.
  before_validation :assign_team
  #требует, чтобы атрибут team не был пустым
  validates :team, presence: true
  #требует, чтобы атрибут unit не был пустым
  validates :unit, presence: true
  #проверяет, что атрибут unit имеет одно из значений: mage, knight, medusa, jinn
  validates :unit, acceptance: { accept: ['mage', 'knight', 'medusa', 'jinn'] }
  validate :is_team_correct

  private
  #проверяет, соответствует ли team правильной команде для данного unit
  def is_team_correct
    errors.add(:unit, 'Error') if CHARACTERS[unit.to_sym] != team
  end
  # устанавливает team, если оно еще не задано
  # используя значение из characters на основе значения unit.
  def assign_team
    if team.nil?
      self.team = CHARACTERS[unit.to_sym]
    end
  end
end