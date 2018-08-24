module VGen
  class ArrayGen
    def initialize(
          min: 4,
          max: 8,
          gens: [ proc {Random.new.rand} ]
        )
      @gens = gens
      @min = min
      @max = max
    end

    def call()
      arr = Array.new(Random.new.rand(@min..@max)) {
        @gens.sample
      }
      arr.map(&:call)
    end
  end
end
