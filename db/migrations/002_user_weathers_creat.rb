# frozen_string_literal: true
require 'sequel'

Sequel.migration do 
  change do
    create_table(:user_weathers) do
      primary_key :id #:primary_key=>true #station's ID
      String :location
      String :weather
      String :icon_weather
      String :icon_wear
      String :icon_mood
      String :icon_activity
      String :icon_festival
      String :icon_situation
    end
  end
end
