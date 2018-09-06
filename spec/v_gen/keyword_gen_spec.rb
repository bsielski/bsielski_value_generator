require "v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::KeywordGen do

  describe "generated samples" do

    context "created without arguments" do
      subject {
        Array.new(300) {
          described_class.new().call
        }
      }

      it "contains only symbols" do
        only_symbols = subject.all? {|e| e.is_a?(Symbol)}
        expect(only_symbols).to be true        
      end

      it "contains only things longer than 3" do
        only_longer_than_3 = subject.all? {|e| e.size > 3}
        expect(only_longer_than_3).to be true     
      end

      it "contains only things shorter than 10" do
        only_shorter_than_10 = subject.all? {|e| e.size < 10}
        expect(only_shorter_than_10).to be true        
      end

      it "contains only lowercase symbols" do
        only_lowercase = subject.all? {|e| e == e.downcase}
        expect(only_lowercase).to be true        
      end

      it "contains some symbols with underscore" do
        any_with_underscore = subject.any? {|sym| sym.to_s.include? "_"}
        expect(any_with_underscore).to be true        
      end

      it "contains none symbols with more than one underscore" do
        max_one_underscore = subject.none? {|sym| sym.to_s.count("_") > 1}
        expect(max_one_underscore).to be true        
      end

      it "contains only symbols with lower letter as the first character" do
        only_lowercase_as_the_first_char = subject.all? {
          |sym| ("a".."z").include? sym.to_s[0]
        }
        expect(only_lowercase_as_the_first_char).to be true        
      end

      it "contains only symbols with lower letter as the last character" do
        only_lowercase_as_the_last_char = subject.all? {
          |sym| ("a".."z").include? sym.to_s[-1]
        }
        expect(only_lowercase_as_the_last_char).to be true        
      end
    end
  end

  context "created with custom letter_gen" do
    subject {
      Array.new(300) {
        described_class.new(
          word_gen: word_gen
        ).()
      }
    }
    let (:word_gen) {
      proc { words.sample }
    }
    let (:words) { ["lol", "rotfl", "omg"] }
    
    it "contains only symbols" do
      only_symbols = subject.all? {|e| e.is_a?(Symbol)}
      expect(only_symbols).to be true        
    end

    it "contains only words from word generator" do
      only_from_generator = subject.all? do |sym|
        words.map(&:downcase).include? sym.to_s
      end
      expect(only_from_generator).to be true        
    end

    it "contains only symbols with lower letter as the first character" do
      only_lowercase_as_the_first_char = subject.all? do |sym|
        ("a".."z").include? sym.to_s[0]
      end
      expect(only_lowercase_as_the_first_char).to be true        
    end

    it "contains only symbols with lower letter as the last character" do
      only_lowercase_as_the_last_char = subject.all? do |sym|
        ("a".."z").include? sym.to_s[-1]
      end
      expect(only_lowercase_as_the_last_char).to be true        
    end
  end

end
