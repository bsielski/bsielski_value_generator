require "bsielski_v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::ArrayGen do

  describe "generated samples" do

    context "called without arguments" do
      subject {
        Array.new(300) {
          described_class.new.()
        }
      }

      it "contains only floats" do
        only_float_arrays =  subject.all? do |arr|
          arr.all? { |e| e.is_a?(Float) }
        end
        expect(only_float_arrays).to be true
      end

      it "contains only floats equal or lesser than 1" do
        only_correct_arrays = subject.all? do |arr|
          arr.all? { |e| e <= 1 }
        end
        expect(only_correct_arrays).to be true
      end

      it "contains only floats equal or greater than 0" do
        only_correct_arrays = subject.all? do |arr|
          arr.all? { |e| e >=0 }
        end
        expect(only_correct_arrays).to be true
      end

      it "contains only arrays longer than 3" do
        only_longer_than_3 = subject.all? {|a| a.size > 3}
        expect(only_longer_than_3).to be true
      end

      it "contains only arrays shorter than 9" do
        only_shorter_than_9 = subject.all? {|a| a.size < 9}
        expect(only_shorter_than_9).to be true        
      end
    end
  end

  context "called with custom gens" do
    subject {
      Array.new(300) {
        described_class.new(
          gens: custom_gens
        ).()
      }
    }
    let (:custom_gens) {
      [
        proc { symbs.sample },
        proc { ints.sample },
        proc { chars.sample }
      ]
    }

    let (:symbs) { [:lol, :rotfl] }
    let (:ints)  { [55555, 666666] }
    let (:chars) { ["A", "B"] }

    it "contains only arrays longer than 3" do
      only_longer_than_3 = subject.all? {|a| a.size > 3}
      expect(only_longer_than_3).to be true
    end

    it "contains only arrays shorter than 9" do
      only_shorter_than_9 = subject.all? {|a| a.size < 9}
      expect(only_shorter_than_9).to be true        
    end

    it "contains only things from gens symbols" do
      things_from_gens = symbs + ints + chars
      only_things_from_gens = subject.all? do |a|
        a.all? { |e| things_from_gens.include? e }
      end
      expect(only_things_from_gens).to be true        
    end
  end

  context "called without arguments" do
    subject {
      Array.new(300) {
        described_class.new(
          min: 0,
          max: 4
        ).()
      }
    }

    it "contains only floats" do
      only_float_arrays =  subject.all? do |arr|
        arr.all? { |e| e.is_a?(Float) }
      end
      expect(only_float_arrays).to be true
    end

    it "contains only floats equal or lesser than 1" do
      only_correct_arrays = subject.all? do |arr|
        arr.all? { |e| e <= 1 }
      end
      expect(only_correct_arrays).to be true
    end

    it "contains only floats equal or greater than 0" do
      only_correct_arrays = subject.all? do |arr|
        arr.all? { |e| e >=0 }
      end
      expect(only_correct_arrays).to be true
    end

    it "contains only arrays longer than -1" do
      only_longer_than_minus_1 = subject.all? {|a| a.size > -1}
      expect(only_longer_than_minus_1).to be true
    end

    it "contains only arrays shorter than 5" do
      only_shorter_than_5 = subject.all? {|a| a.size < 5}
      expect(only_shorter_than_5).to be true        
    end
  end
end
