require "v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::FloatGen do

  context "called without arguments" do
    subject {
      described_class.new(
      ).()
    }
    30.times do
      it "is an float" do
        expect(subject).to be_a Float
      end
      
      it "is >= 0" do
        expect(subject).to be >= -10
      end

      it "is <= 10" do
        expect(subject).to be <= 10
      end
    end
  end

  context "called with big range arguments" do
    subject {
      described_class.new(
        range
      ).()
    }
    let (:range) {(min..max)}
    let (:min) {
      range = (
        -1_000_000_000..1_000_000_000
      )
      Random.new.rand(range)
    }
    let (:max) {
      range_size = (
        0..1_000
      )
      min + Random.new.rand(range_size)
    }

    30.times do
      it "is an float" do
        expect(subject).to be_a Float
      end
      
      it "is >= min from range" do
        expect(subject).to be >= min
      end

      it "is <= max from range" do
        expect(subject).to be <= max
      end
    end
  end

  context "called with small range arguments" do
    subject {
      described_class.new(
        range
      ).()
    }
    let (:range) {(min..max)}
    let (:min) {
      range = (
        -1_000_000_000..1_000_000_000
      )
      Random.new.rand(range)
    }
    let (:max) {
      range_size = (
        0..2
      )
      min + Random.new.rand(range_size)
    }

    30.times do
      it "is an float" do
        expect(subject).to be_a Float
      end
      
      it "is >= min from range" do
        expect(subject).to be >= min
      end

      it "is <= max from range" do
        expect(subject).to be <= max
      end
    end
  end
end
