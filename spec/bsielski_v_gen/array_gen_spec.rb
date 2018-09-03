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

      it "contains only arrays shorter than 10" do
        only_shorter_than_10 = subject.all? {|a| a.size < 10}
        expect(only_shorter_than_10).to be true        
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

    it "contains only arrays shorter than 10" do
      only_shorter_than_10 = subject.all? {|a| a.size < 10}
      expect(only_shorter_than_10).to be true        
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


  200.times do
    context "called with custom size" do
      subject {
        described_class.new(
          size: size
        ).()
      }

      context "size is integer" do
        let (:size) { Random.new.rand(0..100) }
        it "has proper length" do
          expect(subject.length).to eq size        
        end
      end

      context "size is negative integer" do
        let (:size) { Random.new.rand(-1000..-1) }
        it "raises an exeption" do
          expect {subject}.to raise_exception "length (size) can't be negative"        
        end
      end

      context "size is range" do
        let (:min) { Random.new.rand(0..100) }
        let (:dispersion) { Random.new.rand(0..100) }
        let (:size) { (min..(min + dispersion)) }
        it "has proper length" do
          expect(subject.length).to satisfy { |length|
            size.include? length
          }        
        end
      end
    end
  end

  200.times do
    context "called with custom length" do
      subject {
        described_class.new(
          length: length
        ).()
      }

      context "length is integer" do
        let (:length) { Random.new.rand(0..100) }
        it "has proper length" do
          expect(subject.length).to eq length        
        end
      end

      context "length is negative integer" do
        let (:length) { Random.new.rand(-1000..-1) }
        it "raises an exeption" do
          expect {subject}.to raise_exception "length (size) can't be negative"        
        end
      end

      context "length is range" do
        let (:min) { Random.new.rand(0..100) }
        let (:dispersion) { Random.new.rand(0..100) }
        let (:length) { (min..(min + dispersion)) }
        it "has proper length" do
          expect(subject.length).to satisfy { |len|
            length.include? len
          }        
        end
      end
    end
  end

  10.times do
    context "with only a few elements" do
      subject {
        described_class.new(
          size: 100,
          gens: [ proc { Random.new.rand(1..100) } ]
        ).()
      }

      it "is not a uniqe array" do
        expect(subject.uniq).to_not eq subject
      end
    end
  end

  10.times do
    context "with only a few elements and 'uniq: false'" do
      subject {
        described_class.new(
          uniq: false,
          size: 100,
          gens: [ proc { Random.new.rand(1..100) } ]
        ).()
      }

      it "is not a uniqe array" do
        expect(subject.uniq).to_not eq subject
      end
    end
  end

  10.times do
    context "with only a few elements and 'uniq: true'" do
      subject {
        described_class.new(
          uniq: true,
          size: 10,
          gens: [ proc { Random.new.rand(1..10) } ]
        ).()
      }

      it "is a uniqe array" do
        expect(subject.uniq).to eq subject
      end
    end
  end
end
