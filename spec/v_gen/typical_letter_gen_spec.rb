require "v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::TypicalLetterGen do

  context "called without arguments" do
    subject {
      described_class.new(
      ).()
    }
    30.times do
      it "is an string" do
        expect(subject).to be_a String
      end

      it "is a single letter" do
        expect(subject.size).to eq 1
      end
      
      it "is some lower case letter" do
        expect(("a".."z")).to include(subject)
      end

      it "generate more \"e\" than \"b\"" do
        samples = Array.new(1000) { described_class.new.() }
        es = samples.count "e"
        bs = samples.count "b"
        expect(es).to be > bs        
      end

      it "generate more \"t\" than \"z\"" do
        samples = Array.new(1000) { described_class.new.() }
        ts = samples.count "t"
        zs = samples.count "z"
        expect(ts).to be > zs        
      end
      
    end
  end
end
