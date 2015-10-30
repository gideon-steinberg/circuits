require 'circuits/component/base'
require 'circuits/component/and'
require 'circuits/component/sr_nand'

module Circuits
  module Component
    # Positive edge triggered D-type flip flop
    class D < Base
      def initialize
        and_gate = Circuits::Component::And.new
        sr_nand_clk = Circuits::Component::SrNand.new
        sr_nand_d = Circuits::Component::SrNand.new
        sr_nand_out = Circuits::Component::SrNand.new
        super(input_count: 2, output_count: 2,
              port_mappings: { d: { type: :input, number: 0 },
                               clk: { type: :input, number: 1 },
                               q: { type: :output, number: 0 },
                               not_q: { type: :output, number: 1 } },
              sub_components: [and_gate, sr_nand_clk, sr_nand_d, sr_nand_out],
              ticks: 4)
        link_sub_components and_gate, sr_nand_clk, sr_nand_d, sr_nand_out
        reset
      end

      def link_sub_components(and_gate, sr_nand_clk, sr_nand_d, sr_nand_out)
        and_gate.a.set sr_nand_clk.not_q
        and_gate.b.set clk
        q.set sr_nand_out.q
        not_q.set sr_nand_out.not_q
        sr_nand_d.not_s.set and_gate.out
        sr_nand_d.not_r.set d
        sr_nand_clk.not_s.set sr_nand_d.not_q
        sr_nand_clk.not_r.set clk
        sr_nand_out.not_s.set sr_nand_clk.not_q
        sr_nand_out.not_r.set sr_nand_d.q
      end

      def reset
        tick
        tock
      end
    end
  end
end
