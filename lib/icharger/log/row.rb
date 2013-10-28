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

      def time
        @fields[2].to_i
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
