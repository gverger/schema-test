require 'rails_helper'

RSpec.describe CharactersController, type: :request do
  describe 'GET' do
    it 'works' do
      get '/characters/3'

      expect(JSON.parse(response.body)).to eq('id' => 3) # Cannot use eq(id: 3)
    end
  end
end
