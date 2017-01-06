# frozen_string_literal: true

Dir.glob('./{config,lib,models,controllers,representers,services,values,workers}/init.rb').each do |file|
  require file
end
