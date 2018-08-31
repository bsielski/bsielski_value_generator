require "bsielski_v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::HashGen do

  describe "generated samples" do
    20.times do
      context "called without arguments" do
        subject { described_class.new.() }

        it "contains only ints as keys" do
          expect(subject.keys).to satisfy do |ks|
            ks.all? { |k| k.is_a?(Integer) }
          end
        end
      
        it "contains only floats as values" do
          expect(subject.values).to satisfy do |vs|
            vs.all? { |v| v.is_a?(Float) }
          end
        end

        it "values equal or lesser than 1" do
          expect(subject.values).to satisfy do |vs|
            vs.all? { |v| v <= 1 }
          end
        end

        it "values equal or greater than 0" do
          expect(subject.values).to satisfy do |vs|
            vs.all? { |v| v >= 0 }
          end
        end

        it "keys equal or lesser than 100" do
          expect(subject.keys).to satisfy do |ks|
            ks.all? { |k| k <= 100 }
          end
        end

        it "keys equal or greater than 0" do
          expect(subject.keys).to satisfy do |ks|
            ks.all? { |k| k >= 0 }
          end
        end

        it "is longer than 3" do
          expect(subject.size).to be > 3        
        end

        it "is shorter than 9" do
          expect(subject.size).to be < 9        
        end
      end
    end

    context "called with custom key gens" do
      subject {
        Array.new(300) {
          described_class.new(
            key_gens: [
              proc { Random.new.rand(-800..-200) },
              proc { ("A".."Z").to_a.sample }
            ]
          ).()
        }
      }

      it "contains some ints as keys" do
        some_ints_as_key = subject.any? do |hash|
          hash.keys.any? { |k| k.is_a?(Integer) }
        end
        expect(some_ints_as_key).to be true
      end

      it "contains some strings as keys" do
        some_strings_as_key = subject.any? do |hash|
          hash.keys.any? { |k| k.is_a?(String) }
        end
        expect(some_strings_as_key).to be true
      end

      it "contains only floats as values" do
        only_floats_as_values = subject.all? do |hash|
          hash.values.all? { |v| v.is_a?(Float) }
        end
        expect(only_floats_as_values).to be true
      end

      it "contains only values equal or lesser than 1" do
        only_correct_values = subject.all? do |hash|
          hash.values.all? { |h| h <= 1 }
        end
        expect(only_correct_values).to be true
      end

      it "contains only values equal or greater than 0" do
        only_correct_values = subject.all? do |hash|
          hash.values.all? { |v| v >= 0 }
        end
        expect(only_correct_values).to be true
      end

      it "contains some keys equal or lesser than -100" do
        some_correct_keys = subject.any? do |hash|
          hash.keys.any? { |k| k.is_a?(Integer) && k <= -100 }
        end
        expect(some_correct_keys).to be true
      end

      it "contains some keys equal or greater than -600" do
        some_correct_keys = subject.any? do |hash|
          hash.keys.any? { |k| k.is_a?(Integer) && k >= -600 }
        end
        expect(some_correct_keys).to be true
      end

      it "contains only hashes biger than 3" do
        only_biger_than_3 = subject.all? do |h|
          h.size > 3
        end
        expect(only_biger_than_3).to be true
      end

      it "contains only hashes smaller than 9" do
        only_smaller_than_9 = subject.all? {|h| h.size < 9}
        expect(only_smaller_than_9).to be true        
      end
    end

    context "called with custom value gens" do
      subject {
        Array.new(300) {
          described_class.new(
            value_gens: [
              proc { Random.new.rand(-2_000..-1_000) },
              proc { ("a".."n").to_a.sample }
            ]
          ).()
        }
      }

      it "contains only ints as keys" do
        only_ints_as_key = subject.all? do |hash|
          hash.keys.all? { |k| k.is_a?(Integer) }
        end
        expect(only_ints_as_key).to be true
      end

      it "contains only keys equal or lesser than 100" do
        only_correct_keys = subject.all? do |hash|
          hash.keys.all? { |k| k <= 100 }
        end
        expect(only_correct_keys).to be true
      end

      it "contains only keys equal or greater than 0" do
        only_correct_keys = subject.all? do |hash|
          hash.keys.all? { |k| k >= 0 }
        end
        expect(only_correct_keys).to be true
      end

      it "contains some strings as values" do
        some_strings_as_value = subject.any? do |hash|
          hash.values.any? { |v| v.is_a?(String) }
        end
        expect(some_strings_as_value).to be true
      end

      it "contains some values equal or lesser than -1000" do
        some_correct_value = subject.any? do |hash|
          hash.values.any? { |v| v.is_a?(Integer) && v <= -1_000 }
        end
        expect(some_correct_value).to be true
      end

      it "contains some values equal or greater than -2000" do
        some_correct_values = subject.any? do |hash|
          hash.values.any? { |v| v.is_a?(Integer) && v >= -2_000 }
        end
        expect(some_correct_values).to be true
      end

      it "contains only hashes biger than 3" do
        only_biger_than_3 = subject.all? do |h|
          h.size > 3
        end
        expect(only_biger_than_3).to be true
      end

      it "contains only hashes smaller than 9" do
        only_smaller_than_9 = subject.all? {|h| h.size < 9}
        expect(only_smaller_than_9).to be true        
      end
    end

    context "called with min and max" do
      subject {
        Array.new(300) {
          described_class.new(
            min: 40,
            max: 42
          ).()
        }
      }

      it "contains only ints as keys" do
        only_ints_as_key = subject.all? do |hash|
          hash.keys.all? { |k| k.is_a?(Integer) }
        end
        expect(only_ints_as_key).to be true
      end

      it "contains only floats as values" do
        only_floats_as_values = subject.all? do |hash|
          hash.values.all? { |v| v.is_a?(Float) }
        end
        expect(only_floats_as_values).to be true
      end

      it "contains only values equal or lesser than 1" do
        only_correct_values = subject.all? do |hash|
          hash.values.all? { |h| h <= 1 }
        end
        expect(only_correct_values).to be true
      end

      it "contains only values equal or greater than 0" do
        only_correct_values = subject.all? do |hash|
          hash.values.all? { |v| v >= 0 }
        end
        expect(only_correct_values).to be true
      end

      it "contains only keys equal or lesser than 100" do
        only_correct_values = subject.all? do |hash|
          hash.values.all? { |h| h <= 100 }
        end
        expect(only_correct_values).to be true
      end

      it "contains only keys equal or greater than 0" do
        only_correct_values = subject.all? do |hash|
          hash.values.all? { |v| v >= 0 }
        end
        expect(only_correct_values).to be true
      end

      it "contains only hashes longer than 39" do
        only_longer_than_39 = subject.all? do |h|
          h.size > 39
        end
        expect(only_longer_than_39).to be true
      end

      it "contains only hashes shorter than 43" do
        only_shorter_than_43 = subject.all? { |h| h.size < 43 }
        expect(only_shorter_than_43).to be true        
      end
    end

    2.times do
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

    2.times do
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
  end
end
