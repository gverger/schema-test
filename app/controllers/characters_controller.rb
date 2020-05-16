# frozen_string_literal: true

class CharactersController < ApplicationController
  def index
    render json: {
      characters: [
        { id: 1,
          first_name: 'Luke',
          last_name: 'Skywalker',
          human: true },
        { id: 2,
          first_name: 'Han',
          last_name: 'Solo',
          human: true },
        { id: 3,
          first_name: 'R2-D2',
          human: false }
      ]
    }
  end
end
