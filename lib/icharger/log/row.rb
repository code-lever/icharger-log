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

      # XXX state of some kind?
      def field1
        @fields[1]
      end

      def time
        @fields[2].to_i
      end

      # XXX always seems to be 1
      def field3

      end

      # XXX always seems to be 0
      def field4

      end

      # XXX VERIFY
      def current
        @fields[5].to_i / 100.0
      end

      def cell(index)
        @fields[11 + index].to_i / 1000.0
      end

      def cell_count
        @fields[11..20].reject{ |v| v.to_i == 0 }.length
      end

      def checksum
        @fields[21].to_i
      end

      private

    end

  end
end
