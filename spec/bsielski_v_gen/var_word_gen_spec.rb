require "bsielski_v_gen/lower_letter_gen"
require "bsielski_v_gen/#{File.basename(__FILE__).chomp("_spec.rb")}"

RSpec.describe VGen::VarWordGen do

  describe "generated samples" do

    context "called without arguments" do
      subject {
        Array.new(300) {
          described_class.new.()
        }
      }

      it "contains only strings" do
        only_strings = subject.all? {|str| str.is_a?(String)}
        expect(only_strings).to be true        
      end

      it "contains only strings longer than 3" do
        only_longer_than_3 = subject.all? {|str| str.size > 3}
        expect(only_longer_than_3).to be true        
      end

      it "contains only strings shorter than 10" do
        only_shorter_than_10 = subject.all? {|str| str.size < 10}
        expect(only_shorter_than_10).to be true        
      end

      it "contains only lowercase strings" do
        only_lowercase = subject.all? {|str| str == str.downcase}
        expect(only_lowercase).to be true        
      end

      it "contains some strings with underscore" do
        any_with_underscore = subject.any? {|str| str.include? "_"}
        expect(any_with_underscore).to be true        
      end

      it "contains none strings with more than one underscore" do
        max_one_underscore = subject.none? {|str| str.count("_") > 1}
        expect(max_one_underscore).to be true        
      end

      it "contains only strings with lower letter as the first character" do
        only_lowercase_as_the_first_char = subject.all? {
          |str| ("a".."z").include? str[0]
        }
        expect(only_lowercase_as_the_first_char).to be true        
      end

      it "contains only strings with lower letter as the last character" do
        only_lowercase_as_the_last_char = subject.all? {
          |str| ("a".."z").include? str[-1]
        }
        expect(only_lowercase_as_the_last_char).to be true        
      end
    end
  end

  context "called with custom letter_gen" do
    subject {
      Array.new(300) {
        described_class.new(
          letter_gen: vowel_gen
        ).()
      }
    }
    let (:vowel_gen) {
      VGen::LowerLetterGen.new(
        only: vowels
      )
    }
    let (:vowels) { ["a", "e", "y", "u", "i", "o"] }
    
    it "contains only strings" do
      only_strings = subject.all? {|str| str.is_a?(String)}
      expect(only_strings).to be true        
    end

    it "contains only strings longer than 3" do
      only_longer_than_3 = subject.all? {|str| str.size > 3}
      expect(only_longer_than_3).to be true        
    end

    it "contains only strings shorter than 10" do
      only_shorter_than_10 = subject.all? {|str| str.size < 10}
      expect(only_shorter_than_10).to be true        
    end

    it "contains only vovel or underscore strings" do
      is_vovel = -> (char) { vowels.include? char }
      is_underscore = -> (char) { char == "_" }
      only_vovels_or_underscore = subject.all? do |str|
        str.chars.all? do |char|
          is_vovel.(char) || is_underscore.(char)
        end
      end
      expect(only_vovels_or_underscore).to be true        
    end

    it "contains some strings with vovels" do
      is_vovel = -> (char) { vowels.include? char }
      any_with_vovels = subject.any? do |str|
        str.chars.any? { |ch| is_vovel.(ch) }
      end
      expect(any_with_vovels).to be true        
    end

    it "contains some strings with underscore" do
      is_underscore = -> (char) { char == "_" }
      any_with_underscore = subject.any? do |str|
        str.chars.any? { |ch| is_underscore.(ch) }
      end
      expect(any_with_underscore).to be true        
    end

    it "contains none strings with more than one underscore" do
      max_one_underscore = subject.none? {|str| str.count("_") > 1}
      expect(max_one_underscore).to be true        
    end

    it "contains only strings with lower letter as the first character" do
      only_lowercase_as_the_first_char = subject.all? do |str|
        ("a".."z").include? str[0]
      end
      expect(only_lowercase_as_the_first_char).to be true        
    end

    it "contains only strings with lower letter as the last character" do
      only_lowercase_as_the_last_char = subject.all? {
        |str| ("a".."z").include? str[-1]
      }
      expect(only_lowercase_as_the_last_char).to be true        
    end
  end

  context "created with word length" do
    subject {
      Array.new(300) {
        described_class.new(
          length: length
        ).()
      }
    }
    
    context "length is 2" do
      let (:length) { (2..2) }
      it "has only length 2 words" do
        only_length_2_strings = subject.all? {|str| str.length == 2}
        expect(only_length_2_strings).to be true        
      end
    end

    context "length is from 7 to 9" do
      let (:length) { (7..9) }
      it "has only length 7 to 9 words" do
        only_length_7_to_9_strings = subject.all? do |str|
          str.length >= 7 || str.length <= 9
        end
        expect(only_length_7_to_9_strings).to be true        
      end
    end
  end

  context "created with except" do
    subject {
      Array.new(300) {
        described_class.new(
          length: (2..2),
          except: exceptions
        ).()
      }
    }
    
    context "should not generate \"ee\"" do
      let (:exceptions) { ["ee"] }
      it "has no \"ee\" words" do
        has_no_ee_words = subject.none? {|str| str == "ee" }
        expect(has_no_ee_words).to be true        
      end
    end

    context "should not generate \"ee\",\"tt\",\"et\",\"te\",\"ta\",\"at\"" do
      let (:exceptions) { ["ee","tt","et","te","ta","at"] }
      it "has no forbiden words" do
        has_no_exceptions = subject.none? do |str|
          str == "ee" ||
          str == "tt" ||
          str == "et" ||
          str == "te" ||
          str == "ta" ||
          str == "at"
        end
        expect(has_no_exceptions).to be true        
      end
    end

  end
end
