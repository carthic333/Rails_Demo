class PagesController < ApplicationController
	def home
	end
	def calc
		@result = params[:a].to_i * params[:b].to_i
	end
end
