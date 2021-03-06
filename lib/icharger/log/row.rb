module ICharger
  module Log

    class Row

      def initialize(raw_line)
        @fields = raw_line.strip.split(';')
        throw ArgumentError, "Unexpected field count (#{@fields.length})" unless @fields.length == 22
      end

      # Gets the charger channel number.
      #
      # @return [Number] charger channel number
      def channel
        /(?<ch>\d)/.match(@fields[0])[:ch].to_i
      end

      # Gets the current state of operation.
      #
      # @return :charging, :discharging, :unknown
      # @note This is a guess...
      def state
        {
          1 => :charging,
          2 => :discharging
        }.fetch(@fields[1].to_i, :unknown)
      end

      # Gets the time in milliseconds.
      #
      # @return [Number] time stamp, in milliseconds
      def time
        @fields[2].to_i
      end

      # XXX always seems to be 1
      def field3
        @fields[3].to_i
      end

      # XXX always seems to be 0
      def field4
        @fields[4].to_i
      end

      # Gets the instantaneous charge (+) or discharge (-) current, in amps.
      #
      # @return [Float] instantaneous current (A)
      def current
        @fields[5].to_i / 100.0
      end

      # Gets the input power supply voltage, in volts.
      #
      # @return [Float] input power supply (V)
      def input_voltage
        @fields[6].to_i / 1000.0
      end

      # Gets the total battery pack voltage, in volts.
      #
      # @return [Float] battery pack voltage (V)
      def pack_voltage
        @fields[7].to_i / 1000.0
      end

      # Gets the capacity stored or removed so far, in amp-hours.
      #
      # @return [Float] amp-hours stored (+) or removed (-)
      def capacity
        @fields[8].to_i / 100.0
      end

      def internal_temperature?
        0 != internal_temperature
      end

      # Gets the internal temperature sensor value, in celsius or fahrenheit.
      #
      # @param unit :c or :f for celsius or fahrenheit
      # @return [Float] temperature in requested unit
      def internal_temperature(unit = :c)
        convert_temperature((@fields[9].to_i / 10.0), unit)
      end

      def external_temperature?
        0 != external_temperature
      end

      # Gets the external temperature sensor value, in celsius or fahrenheit.
      #
      # @param unit :c or :f for celsius or fahrenheit
      # @return [Float] temperature in requested unit
      def external_temperature(unit = :c)
        convert_temperature((@fields[10].to_i / 10.0), unit)
      end

      # Gets the individual cell voltage, in volts.
      #
      # @param index index of the cell (0-based)
      # @return [Float] specified cell voltage (V)
      # @see #cell_count
      def cell_voltage(index)
        @fields[11 + index].to_i / 1000.0
      end

      # Gets the number of individual cells measured.
      #
      # @return [Number] number of individual cells
      # @see #cell_voltage
      def cell_count
        @fields[11..20].count { |v| v.to_i.nonzero? }
      end

      def field21
        @fields[21].to_i
      end

      private

      def convert_temperature(celsius, unit)
        case unit
        when :f
          (celsius * (9.0 / 5.0)) + 32
        else
          celsius
        end
      end

    end

  end
end
