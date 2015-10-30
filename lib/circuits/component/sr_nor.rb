require 'circuits/component/base'
require 'circuits/component/nor'

module Circuits
  module Component
    # SR NOR Latch
    class SrNor < Base
      def initialize
        nor_s = Nor.new
        nor_r = Nor.new
        super(input_count: 2, output_count: 2,
              port_mappings: { r: { type: :input, number: 0 },
                               s: { type: :input, number: 1 },
                               q: { type: :output, number: 0 },
                               not_q: { type: :output, number: 1 } },
              sub_components: [nor_s, nor_r],
              ticks: 2)

        nor_r.a.set r
        nor_r.b.set nor_s.out

        nor_s.a.set s
        nor_s.b.set nor_r.out

        q.set nor_r.out
        not_q.set nor_s.out

        r.set true
        tick
        tock
        r.set false
      end
    end
  end
end
