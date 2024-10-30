class Character < ApplicationRecord
  UNITS_TO_TEAMS = {
    mage: 1,
    knight: 1,
    medusa: 2,
    jinn: 2
  }.freeze

  ACCEPTABLE_UNITS = UNITS_TO_TEAMS.keys.map(&:to_s).freeze

  # позволяет задать команду автоматически, если она не указана, еще до валидации.
  before_validation :assign_team
  #требует, чтобы атрибут team не был пустым
  validates :team, presence: true
  #требует, чтобы атрибут unit не был пустым
  validates :unit, presence: true
  #проверяет, что атрибут unit имеет одно из значений: mage, knight, medusa, jinn
  validates :unit, acceptance: { accept: ACCEPTABLE_UNITS }
  validate :correct_team?

  scope :team1, -> { where(team: 1) }
  scope :team2, -> { where(team: 2) }

  scope :knights, -> { team1.where(unit: 'knight') }
  scope :mages, -> { team1.where(unit: 'mage') }
  scope :jinns, -> { team2.where(unit: 'jinn') }
  scope :medusas, -> { team2.where(unit: 'medusa') }

  def self.ultimate_for(team:)
    return unless Character.ultimate_ready_for?(team:)

    if team == 1
      5.times { Character.create(unit: 'knight') }
    elsif team == 2
      Character.team1.sample(3).each(&:destroy)
    end
  end

  def self.ultimate_ready_for?(team:)
    if team == 1
      Character.knights.count >= 2 && Character.mages.count >= 2
    elsif team == 2
      Character.jinns.count >= 2 && Character.medusas.count >= 1
    else
      false
    end
  end

  def self.create_sample!
    unit, team = Character::UNITS_TO_TEAMS.to_a.sample
    Character.create!(team:, unit:)
  end

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