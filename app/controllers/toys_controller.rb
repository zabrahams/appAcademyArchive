class ToysController < ApplicationController

  def show
    @toy = Toy.find(params[:id])
    render 'show'
  end

  def update
    @toy = Toy.find(params[:id])
    if (@toy.update(pokemon_id: params[:toy][:pokemon_id]))
      render json: @toy
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end


end
