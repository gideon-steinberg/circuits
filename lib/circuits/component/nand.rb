require 'circuits/component/base'

module Circuits
  module Component
    # Logical NAND Operator
    class Nand < Base
      def initialize(opts = {})
        input_count = opts[:input_count] || 2
        super(input_count: input_count, output_count: 1)
      end

      # Sets the output to be the result of a logical NAND of the inputs
      def tick
        self[:out].set(!inputs.map(&:get).inject(:&))
      end
    end
  end
end
