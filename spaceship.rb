require "Gosu"

class Spaceship

	TURN_INCREMENT = 4.5

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("media/starfighter.bmp")
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= TURN_INCREMENT
	end

	def turn_right
		@angle += TURN_INCREMENT
	end

	def acceleration
		@vel_x += Gosu::offset_x(@angle, ACCELERATION)
		@vel_y += Gosu::offset_y(@angle, ACCELERATION)
	end

	def move
	@x += @vel_x
	@y += @vel_y

	@x %= 640
	@y %= 480

	@vel_x *= 0.95
	@vel_y *= 0.95	
	end

	def draw
		@image.draw_rot(@x, @y, 1, @angle)		
	end	

end