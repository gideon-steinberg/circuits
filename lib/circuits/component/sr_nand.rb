require 'circuits/component'

module Circuits
  module Component
    # SR NAND Latch
    class SrNand
      include Component

      # Computes the outputs based on the inputs and previous state
      def tick
        2.times.each do
          sub_components.each(&:tick)
          sub_components.each(&:tock)
        end
        self[:q].set nand_1[:out].get
        self[:not_q].set nand_2[:out].get
      end

      private

      attr_reader :nand_1, :nand_2, :sub_components

      def set_defaults
        @input_count = 2
        @output_count = 2
        @port_mappings = {
          not_s: { type: :input, number: 0 },
          not_r: { type: :input, number: 1 },
          q: { type: :output, number: 0 },
          not_q: { type: :output, number: 1 }
        }
      end

      def setup
        @nand_1 = Nand.new
        @nand_2 = Nand.new
        @sub_components = [@nand_1, @nand_2]
        nand_1[:a] = self[:not_s]
        nand_2[:a] = self[:not_r]
        nand_1[:b] = nand_2[:out]
        nand_2[:b] = nand_1[:out]
      end
    end
  end
end
