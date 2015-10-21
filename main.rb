require "Gosu"
require_relative 'player'
require_relative 'z_order'
require_relative 'stars'

class GameWindow < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Gosu Tutorial Game"

		@background_image = Gosu::Image.new("media/space.png", 
																				:tileable => true)

		@player = Player.new
		@player.warp(width/2.0, height/2.0)

		@star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
		@stars = Array.new
		@font = Gosu::Font.new(20)
	end

	def update
		@player.turn_left if Gosu::button_down? Gosu::KbLeft
		@player.turn_right if Gosu::button_down? Gosu::KbRight
		@player.accelerate if Gosu::button_down? Gosu::KbUp

		@player.move
		@player.collect_stars(@stars)

		if rand(25) < 20 && @stars.size < 50
			@stars.push(Star.new(@star_anim))
		end
	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		@stars.each { |star| star.draw }
		@font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
	end

	def button_down(id)
		close if id == Gosu::KbEscape
		
	end
end

window = GameWindow.new
window.show