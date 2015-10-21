require "Gosu"
require_relative "z_order"

class Player

	TURN_INCREMENT = 5.5
	ACCELERATION = 0.5
	COLLISION_DISTANCE = 30

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("media/asian.jpg")
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

	def accelerate
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
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
	end	

	def score
		@score
	end


	def collect_stars(stars)
		if stars.reject! {|star| Gosu::distance(@x, @y, star.x, star.y) < COLLISION_DISTANCE}
			@score += 1
		end
	end

	private

	def colliding?(star)
		Gosu::distance(@x, @y, star.x, star.y) < COLLISION_DISTANCE
	end

end