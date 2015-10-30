require 'circuits/component/base'
require 'circuits/component/nand'

module Circuits
  module Component
    # SR NAND Latch
    class SrNand < Base
      def initialize
        nand_s = Nand.new
        nand_r = Nand.new
        super(input_count: 2, output_count: 2,
              port_mappings: { not_s: { type: :input, number: 0 },
                               not_r: { type: :input, number: 1 },
                               q: { type: :output, number: 0 },
                               not_q: { type: :output, number: 1 } },
              sub_components: [nand_s, nand_r],
              ticks: 2)

        nand_r.a.set not_r
        nand_r.b.set nand_s.out
        nand_s.a.set not_s
        nand_s.b.set nand_r.out
        q.set nand_s.out
        not_q.set nand_r.out

        not_s.set true
        tick
        tock
        not_r.set true
      end
    end
  end
end
