# frozen_string_literal: true

module Facter
  module Resolvers
    module Macosx
      class Mountpoints < BaseResolver
        include Facter::FilesystemHelper
        @semaphore = Mutex.new
        @fact_list ||= {}
        @log = Facter::Log.new(self)
        class << self
          private

          def post_resolve(fact_name)
            @fact_list.fetch(fact_name) { read_mounts }
          end

          def read_mounts # rubocop:disable Metrics/AbcSize
            mounts = []
            FilesystemHelper.read_mountpoints.each do |fs|
              device = fs.name
              filesystem = fs.mount_type
              path = fs.mount_point
              options = fs.options.split(',').map(&:strip).map { |o| o == 'rootfs' ? 'root' : o }

              next if path =~ %r{^/(proc|sys)} && filesystem != 'tmpfs' || filesystem == 'autofs'

              stats = FilesystemHelper.read_mountpoint_stats(path)
              size_bytes = stats.bytes_total

              used_bytes = stats.bytes_used
              available_bytes = size_bytes - used_bytes
              capacity = FilesystemHelper.compute_capacity(used_bytes, size_bytes)

              size = Facter::BytesToHumanReadable.convert(size_bytes)
              available = Facter::BytesToHumanReadable.convert(available_bytes)
              used = Facter::BytesToHumanReadable.convert(used_bytes)

              mounts << Hash[FilesystemHelper::MOUNT_KEYS.zip(FilesystemHelper::MOUNT_KEYS
                .map { |v| binding.local_variable_get(v) })]
            end
            @fact_list[:mountpoints] = mounts
          end
        end
      end
    end
  end
end
