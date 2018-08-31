module VGen
  class ArrayGen
    def initialize(
          min: 4,
          max: 9,
          length: nil,
          size: nil,
          gens: [ proc {Random.new.rand} ]
        )
      @length = length || size || (min..max)
      @gens = gens
      @min = min
      @max = max
    end

    def call()
      arr = Array.new(array_length) {
        @gens.sample
      }
      arr.map(&:call)
    end
        
    private

    def array_length
      length = Random.new.rand(@length) if @length.is_a? Range
      length = @length if @length.is_a? Integer
      raise "length (size) can't be negative" if length < 0
      length
    end
  end
end
