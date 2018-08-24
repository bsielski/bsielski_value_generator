require_relative "./typical_letter_gen"

module VGen
  class VarWordGen
    def initialize(
          letter_gen: TypicalLetterGen.new,
          length: (4..9),
          except: []
        )
      @length = length
      @letter_gen = letter_gen
      @except = except
    end

    def call()
      loop do
        word = Array.new(
          Random.new.rand(@length),
          @letter_gen
        ).map(&:call).join
        if word.size > 2
          if Random.new.rand(1..100) < 15
            word[Random.new.rand(1..word.size - 2)] = "_"
          end
        end
        return word unless @except.include? word
      end
    end
  end
end
