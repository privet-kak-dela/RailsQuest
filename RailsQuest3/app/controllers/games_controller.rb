class GamesController < ApplicationController
  def restart
    Character.destroy_all

    redirect_to :root
  end

  # если лень создавать своих челиков после рестарта,то можно сгенерировать случайно четырех челиков из случайных команд
  # -Почему 4?
  # -просто, число прикольное)
  def generate
    4.times { Character.create_sample! }

    redirect_to :root
  end
end
