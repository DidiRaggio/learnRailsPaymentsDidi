class PerchasesController < ApplicationController
  def show
		@perchase = Perchase.find(params[:id])
  end
end
