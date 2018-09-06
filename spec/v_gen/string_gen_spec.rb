require "v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::StringGen do
  let (:value) { generator.call }
  let (:values) { Array.new(300){generator.call} }
  let (:char_gen) { double("Char Gen") }

  context "constructor without arguments" do
    let (:generator) {
      described_class.new
    }
  
    it "has default char_gen 'TypicalLetterGen'" do
      expect(generator.char_gen).to be_a VGen::LetterGen
    end

    it "generates (4..9) long string" do
      lengths = values.map(&:length)
      default_length = (4..9).to_a
      expect(lengths).to include(*default_length)
    end
  end

  context "constructor with custom length and char_gen" do
    let (:length) {
      Random.new.rand((1..20))
    }
    let (:chars_out) {
      Array.new(20) {
        (("a".."z").to_a + ("A".."Z").to_a).sample
      }
    }
    let (:generator) {
      described_class.new(
        char_gen: char_gen,
        length: length
      )
    }

    before do
      allow(char_gen)
        .to receive(:call)
              .and_return(*chars_out)
    end
  
    30.times do
      it "uses char_gen to generate strings" do
        expect(value).to eq chars_out.first(length).join
      end
    end    
  end

  context "low length, low char variations, custom" do
    let (:length) {
      Random.new.rand((1..2))
    }
    
    
    let (:generator) {
      described_class.new(
        char_gen: char_gen,
        length: length,
        except: exceptions
      )
    }
    let (:exceptions) {
      %W[A B C D AA AB AC AD BA BB BC BD CA CB CC CD DA DB DC DD ].sample(3)
    }

    let (:chars_out) {
      Array.new(600) {
        ("A".."D").to_a.sample
      }
    }
    
    before do
        allow(char_gen)
          .to receive(:call)
                .and_return(*chars_out)
    end

    300.times do
      it "doesn't generate strings from 'except'" do
        # puts "LENGTH: #{length}"
        # puts "EXCEPTIONS: #{exceptions.inspect}"
        # puts "CHARS_OUT: #{chars_out.inspect}"
        # puts "VALUE: #{value}"
        expect(exceptions).to_not include(value)
      end
    end
  end
end
