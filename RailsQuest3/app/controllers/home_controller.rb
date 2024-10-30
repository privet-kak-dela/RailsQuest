class HomeController < ApplicationController
  def index
    @team1 = Character.where(team: 1)
    @team2 = Character.where(team: 2)
    @is_ulta1_allow = ulta1_allow
    @is_ulta2_allow = ulta2_allow
    @is_generate_allow = Character.count.zero? #если бд пустая, то можно сгенерировать новую случайную игру
  end

  #создает запись в бд с переданными параметрами(получает и разрешает параметры team и uni)
  def new_сharacter
    Character.create(params.require(:character).permit(:team, :unit))
    redirect_to '/'
  end

  #если в команде 1 есть хотя бы два мага и два рыцаря, то далее можно будет активировать кнопку
  def ulta1_allow
    Character.where(team: 1, unit: :knight).count >= 2 && Character.where(team: 1, unit: :mage).count >= 2
  end
  #если в команде два есть 2 джинна и 1 медуза, то далее можно будет активировать кнопку
  def ulta2_allow
    Character.where(team: 2, unit: :jinn).count >= 2 && Character.where(team: 2, unit: :medusa).count >= 1
  end

  #создает 5 рыцарей, если в команде 1 есть хотя бы два мага и два рыцаря
  def ulta1_activate
    5.times do
      Character.create({ team: 1, unit: 'knight' })
    end
    redirect_to '/'
  end

  #удаляет 3 рандомных челиков, если в команде два есть 2 джинна и 1 медуза
  def ulta2_activate
    [3, Character.where(team: 1).count].min.times do |_|
      Character.where(team: 1).sample.destroy
    end
    redirect_to '/'
  end

  #удаляет всё, чтоб можно было начать с чистого листа
  def restart
    Character.destroy_all
    redirect_to '/'
  end

  # если лень создавать своих челиков после рестарта,то можно сгенерировать случайно четырех челиков из случайных команд
  # -Почему 4?
  # -просто, число прикольное)
  def generate_game
    4.times do
      random_unit = Character::UNITS_TO_TEAMS.keys.sample #берем рандомного челика
      random_team = Character::UNITS_TO_TEAMS[random_unit] #смотрим, в какой он команде
      Character.create(team: random_team,unit: random_unit)
    end
    redirect_to '/'
  end
end