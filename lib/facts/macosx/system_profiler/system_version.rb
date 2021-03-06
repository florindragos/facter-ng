# frozen_string_literal: true

module Facts
  module Macosx
    module SystemProfiler
      class SystemVersion
        FACT_NAME = 'system_profiler.system_version'

        def call_the_resolver
          fact_value = Facter::Resolvers::SystemProfiler.resolve(:system_version)
          Facter::ResolvedFact.new(FACT_NAME, fact_value)
        end
      end
    end
  end
end
