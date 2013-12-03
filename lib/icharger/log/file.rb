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
        raise ArgumentError, 'No records found in file' if @rows.empty?
      rescue => e
        raise ArgumentError, "File does not appear to be an iCharger log (#{e})"
      end

      # Gets the charger channel number.
      #
      # @return [Number] charger channel number
      def channel
        @rows.first.channel
      end

      # Gets the duration of the log, in seconds.
      #
      # @return [Float] duration of the log, in seconds
      def duration
        @rows.last.time / 10000.0
      end

      def milliseconds
        @rows.map(&:time)
      end

      def currents
        @rows.map(&:current)
      end

      def input_voltages
        @rows.map(&:input_voltage)
      end

      def pack_voltages
        @rows.map(&:pack_voltage)
      end

      def capacities
        @rows.map(&:capacity)
      end

      def internal_temperatures?
        @rows.map(&:internal_temperature?).any? { |t| t }
      end

      def internal_temperatures(unit = :c)
        @rows.each_with_object(unit).map(&:internal_temperature)
      end

      def external_temperatures?
        @rows.map(&:external_temperature?).any? { |t| t }
      end

      def external_temperatures(unit = :c)
        @rows.each_with_object(unit).map(&:internal_temperature)
      end

      def cell_voltages(index)
        @rows.each_with_object(index).map(&:cell_voltage)
      end

      def cell_count
        @rows.map(&:cell_count).max
      end

    end

  end
end
