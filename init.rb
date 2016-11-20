# frozen_string_literal: true

Dir.glob('./{config,lib,models,controllers,queries,representers,service,values}/init.rb').each do |file|
  require file
end
