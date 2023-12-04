class Game
  def initialize(input)
    @game_id = input.scan(/Game (\d*):/).flatten.first.to_i
    
    @gameSets = []
    input.scan(/:(.*)$/).flatten.first.split(";").each do |gameSet|
      @gameSets << GameSet.new(gameSet)
    end
  end

  def is_game_possible?
    @gameSets.all? { |gameSet| gameSet.possible?}
  end

  def game_id
    @game_id
  end

  def red_cubes_needed
    @gameSets.map { |gameSet| gameSet.red_cubes }.max
  end

  def green_cubes_needed
    @gameSets.map { |gameSet| gameSet.green_cubes }.max
  end

  def blue_cubes_needed  
    @gameSets.map { |gameSet| gameSet.blue_cubes }.max
  end

  def multipler
    red_cubes_needed * green_cubes_needed * blue_cubes_needed
  end
end

class GameSet
  def initialize(input)
    @input = input
  end

  def blue_cubes
    @input.scan(/(\d+) blue/).flatten.first.to_i
  end

  def red_cubes
    @input.scan(/(\d+) red/).flatten.first.to_i
  end

  def green_cubes
    @input.scan(/(\d+) green/).flatten.first.to_i
  end

  def possible?
    red_cubes <= MAX_CUBE_COUNT[:red] && 
    blue_cubes <= MAX_CUBE_COUNT[:blue] && 
    green_cubes <= MAX_CUBE_COUNT[:green]
  end
end