require "v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::LetterGen do

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
      
      it "is some letter" do
        letters = ("A".."Z").to_a + ("a".."z").to_a
        expect(letters).to include(subject)
      end
    end
  end

  context "called with exceptions" do
    subject {
      described_class.new(
        except: exceptions
      ).()
    }
    let (:exceptions) { ("a".."z").to_a.sample(15) }

    30.times do
      it "is an string" do
        expect(subject).to be_a String
      end
      
      it "is a single letter" do
        expect(subject.size).to eq 1
      end
      
      it "has not any exceptions" do
        expect(exceptions).to_not include(subject)
      end
    end
  end

  context "called with \"only\"" do
    subject {
      described_class.new(
        only: allowed
      ).()
    }
    let (:allowed) { letters.sample(10) }
    let (:letters) { ("A".."Z").to_a + ("a".."z").to_a }

    30.times do
      it "is an string" do
        expect(subject).to be_a String
      end
      
      it "is a single letter" do
        expect(subject.size).to eq 1
      end
      
      it "is some letter" do
        expect(letters).to include(subject)
      end
      
      it "has only letters that are allowed" do
        expect(allowed).to include(subject)
      end
    end
  end

  context "called with \"only\" and \"exceptions\"" do
    subject {
      described_class.new(
        only: allowed,
        except: exceptions
      ).()
    }
    let (:allowed) { letters.to_a.sample(20) }
    let (:exceptions) { letters.to_a.sample(20) }
    let (:letters) { ("A".."Z").to_a + ("a".."z").to_a }

    30.times do
      it "is an string" do
        expect(subject).to be_a String
      end

      it "is a single letter" do
        expect(subject.size).to eq 1
      end

      it "is some letter" do
        expect(letters).to include(subject)
      end

      it "has only letters that are allowed" do
        expect(allowed).to include(subject)
      end

      it "has not any exceptions" do
        expect(exceptions).to_not include(subject)
      end
    end
  end
end
