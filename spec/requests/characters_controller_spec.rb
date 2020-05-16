# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CharactersController, type: :request do
  describe 'with classic rspec helpers' do
    context 'when valid' do
      it 'passes' do
        get '/characters'

        characters = JSON.parse(response.body)['characters']

        expect(characters)
          .to all(include(
                    'id' => be_an(Integer),
                    'first_name' => be_a(String),
                    'human' => be_in([true, false])
                  ))

        # Not sure how to best test an optional field
        expect(characters.map { |c| c['last_name'] }.compact).to all(be_a(String))
      end
    end

    context 'when invalid' do
      it 'passes' do
        get '/characters'

        expect(JSON.parse(response.body)['characters'])
          .to all(include(
                    'id' => be_an(Integer),
                    'first_name' => be_a(String),
                    'last_name' => be_a(String),
                    'human' => be_in([true, false])
                  ))
      end
    end
  end

  describe 'with dry-schema' do
    let(:index_schema) do
      char_schema = character_schema
      Dry::Schema.JSON do
        required(:characters).array(char_schema) # wont let me use character_schema variable directly
      end
    end

    context 'when valid' do
      let(:character_schema) do
        Dry::Schema.JSON do
          required(:id).filled(:integer)
          required(:first_name).filled(:string)
          optional(:last_name).filled(:string)
          required(:human).filled(:bool)
        end
      end

      it 'passes' do
        get '/characters'

        res = index_schema.call(JSON.parse(response.body))

        expect(res.errors.to_h).to be_empty # => PASS
      end
    end

    context 'when invalid' do
      let(:character_schema) do
        Dry::Schema.JSON do
          required(:id).filled(:integer)
          required(:first_name).filled(:string)
          required(:last_name).filled(:string) # R2-D2 doesn't have any last name
          required(:human).filled(:bool)
        end
      end

      it 'fails' do
        get '/characters'

        res = index_schema.call(JSON.parse(response.body))

        expect(res.errors.to_h).to be_empty # => FAIL
      end
    end
  end
end
