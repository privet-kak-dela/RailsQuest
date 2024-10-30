module CharactersHelper
  def new_game?
    Character.count.zero?
  end

  def ultimate_ready_for?(team:)
    Character.ultimate_ready_for?(team:)
  end
end
