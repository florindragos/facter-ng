# frozen_string_literal: true

module Facter
  module Macosx
    class Mountpoints
      FACT_NAME = 'mountpoints'

      def call_the_resolver
        mountpoints = Resolvers::Macosx::Mountpoints.resolve(FACT_NAME.to_sym)
        return ResolvedFact.new(FACT_NAME, nil) unless mountpoints

        fact = {}
        mountpoints.each do |mnt|
          fact[mnt[:path].to_sym] = mnt.reject { |k| k == :path }
        end

        ResolvedFact.new(FACT_NAME, fact)
      end
    end
  end
end
