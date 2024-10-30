class CharactersController < ApplicationController
  def index
  end

  #создает запись в бд с переданными параметрами(получает и разрешает параметры team и uni)
  def create
    character = Character.new(character_params)

    flash[:alert] = character.errors.full_messages unless character.save

    redirect_to :root
  end

  def ultimate
    Character.ultimate_for(team: params.require(:team).to_i)

    redirect_to :root
  end

  private

  def character_params
    params.require(:character).permit(:team, :unit)
  end
end