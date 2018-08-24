module VGen
  class HashGen
    def initialize(
          min: 4,
          max: 8,
          key_gens:   [ proc {Random.new.rand(0..100)} ],
          value_gens: [ proc {Random.new.rand} ]
        )
      @key_gens = key_gens
      @value_gens = value_gens
      @min = min
      @max = max
    end
    
    def call()
      length = Random.new.rand(@min..@max)
      hash = Hash[
        Array.new(length) do
          [
            @key_gens.sample.call,
            @value_gens.sample.call
          ]
        end
      ]
      while hash.size < length do
        hash = hash.merge(
          {
            @key_gens.sample.call => @value_gens.sample.call
          }
        )
      end
      hash
    end
  end
end
