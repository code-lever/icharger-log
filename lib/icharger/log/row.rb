module ICharger
  module Log

    class Row

      def initialize(raw_line)
        @fields = raw_line.strip.split(';')
        throw ArgumentError, "Unexpected field count (#{@fields.length})" unless @fields.length == 22
      end

      def channel
        /(?<ch>\d)/.match(@fields[0])[:ch].to_i
      end

      # this is a guess...
      def state
        {
          1 => 'charging',
          2 => 'discharging'
        }.fetch(@fields[1].to_i, 'unknown')
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

      # Instantaneous charge (+) or discharge (-) current, in amps.
      #
      # @return [Float] instantaneous current (A)
      def current
        @fields[5].to_i / 100.0
      end

      # Input power supply voltage, in volts.
      #
      # @return [Float] input power supply (V)
      def input_voltage
        @fields[6].to_i / 1000.0
      end

      # XXX voltage measured?
      def field7
        @fields[7].to_i / 1000.0
      end

      # Capacity stored or removed so far, in amp-hours.
      #
      # @return amp-hours stored (+) or removed (-)
      def capacity
        @fields[8].to_i / 100.0
      end

      # Internal temperature sensor value, in celsius or fahrenheit.
      #
      # @param unit :c or :f for celsius or fahrenheit
      # @return [Float]
      def internal_temperature(unit = :c)
        @temperature ||= @fields[9].to_i
        case unit
        when :f
          (@temperature * (9.0 / 5.0)) + 32
        else
          @temperature
        end
      end

      # XXX always seems to be 0, external temp. sensor?
      def field10
        @fields[10]
      end

      def cell(index)
        @fields[11 + index].to_i / 1000.0
      end

      def cell_count
        @fields[11..20].reject{ |v| v.to_i == 0 }.length
      end

      def field21
        @fields[21].to_i
      end

      private

    end

  end
end
