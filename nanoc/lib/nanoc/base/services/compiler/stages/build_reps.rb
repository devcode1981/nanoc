# frozen_string_literal: true

module Nanoc
  module Int
    class Compiler
      module Stages
        class BuildReps < Nanoc::Core::CompilationStage
          def initialize(site:, action_provider:)
            @site = site
            @action_provider = action_provider
          end

          def run
            reps = Nanoc::Core::ItemRepRepo.new

            builder = Nanoc::Int::ItemRepBuilder.new(
              @site, @action_provider, reps
            )

            action_sequences = builder.run

            @site.layouts.each do |layout|
              action_sequences[layout] = @action_provider.action_sequence_for(layout)
            end

            {
              reps: reps,
              action_sequences: action_sequences,
            }
          end
        end
      end
    end
  end
end
