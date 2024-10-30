class HomeController < ApplicationController
  def index
  end

  #создает запись в бд с переданными параметрами(получает и разрешает параметры team и uni)
  def new_сharacter
    character = Character.new(character_params)

    flash[:alert] = character.errors.full_messages unless character.save

    redirect_to :root
  end

  #создает 5 рыцарей, если в команде 1 есть хотя бы два мага и два рыцаря
  def ultimate
    Character.ultimate_for(team: params.require(:team).to_i)

    redirect_to :root
  end

  #удаляет всё, чтоб можно было начать с чистого листа
  def restart
    Character.destroy_all

    redirect_to :root
  end

  # если лень создавать своих челиков после рестарта,то можно сгенерировать случайно четырех челиков из случайных команд
  # -Почему 4?
  # -просто, число прикольное)
  def generate_game
    4.times { Character.create_sample! }

    redirect_to :root
  end

  private

  def character_params
    params.require(:character).permit(:team, :unit)
  end
end