# frozen_string_literal: true

class CharactersController < ApplicationController
  def show
    render json: { id: character_id }
  end

  def character_id
    params.require(:id).to_i
  end
end
