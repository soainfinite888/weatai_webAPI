# frozen_string_literal: true
require 'sequel'

Sequel.migration do 
  change do
    create_table(:user_weathers) do
      primary_key :id 
      String :lat #latitude
      String :lng #longitude
      String :icon
      Timestamp :upload_time
    end
  end
end
