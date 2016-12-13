# frozen_string_literal: true
require 'sequel'

Sequel.migration do 
  change do
    create_table(:user_weathers) do
      primary_key :id #:primary_key=>true #station's ID
      String :location
      String :icon_weather
      String :icon_situation
      String :icon_side
      String :icon_activity
      String :icon_emotion
      String :icon_festival
      Timestamp :upload_time
    end
  end
end
