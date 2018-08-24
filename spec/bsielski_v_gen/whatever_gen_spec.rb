require "bsielski_v_gen/int_gen"
require "bsielski_v_gen/float_gen"
require "bsielski_v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::WhateverGen do
  describe "generated samples" do

    context "called without gens" do
      subject {
        Array.new(300) {
          described_class.new.()
        }
      }

      it "contains only floats" do
        only_floats = subject.all? {|f| f.is_a?(Float)}
        expect(only_floats).to be true        
      end

      it "only smaller or equal to than 1" do
        only_less_than_1 = subject.all? { |f| f <= 1 }
        expect(only_less_than_1).to be true        
      end

      it "only bigger or equal to than 0" do
        only_greater_than_0 = subject.all? { |f| f >= 0 }
        expect(only_greater_than_0).to be true        
      end
    end

    context "called without gens" do
      subject {
        Array.new(300) {
          described_class.new.()
        }
      }

      it "contains only floats" do
        only_floats = subject.all? {|f| f.is_a?(Float)}
        expect(only_floats).to be true        
      end

      it "only smaller or equal to than 1" do
        only_less_than_1 = subject.all? { |f| f <= 1 }
        expect(only_less_than_1).to be true        
      end

      it "only bigger or equal to than 0" do
        only_greater_than_0 = subject.all? { |f| f >= 0 }
        expect(only_greater_than_0).to be true        
      end
    end

    context "called with three custom gens" do
      subject {
        Array.new(300) {
          described_class.new(
            gens: gens
          ).()
        }
      }

      let (:gens) {
        [
          proc { "A" },
          proc {  1  },
          proc {  0  }
        ]
      }

      it "contains some A" do
        any_a = subject.any? { |v| v == "A" }
        expect(any_a).to be true        
      end

      it "contains some 1" do
        any_1 = subject.any? { |v| v == 1 }
        expect(any_1).to be true
      end

      it "contains some 0" do
        any_0 = subject.any? { |v| v == 0 }
        expect(any_0).to be true
      end
    end
  end
end
