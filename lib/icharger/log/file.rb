require 'open-uri'

module ICharger
  module Log

    class File

      attr_reader :rows

      # Determines if the file at the given URI is an iCharger log file.
      #
      # @param uri URI to file to read
      # @return [ICharger::Log::File] loaded file if the file is an iCharger log file, nil otherwise
      def self.icharger?(uri)
        File.new(uri) rescue nil
      end

      def initialize(uri)
        open(uri, 'r') do |file|
          @rows = file.readlines.map { |row| ICharger::Log::Row.new(row) }
        end
        raise ArgumentError, "No records found in file" if @rows.empty?
      rescue => e
        raise ArgumentError, "File does not appear to be an iCharger log (#{e})"
      end

      def channel
        @rows.first.channel
      end

      def duration
        @rows.last.time / 10000.0
      end

    end

  end
end
