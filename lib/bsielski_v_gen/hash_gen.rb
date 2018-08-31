module VGen
  class HashGen
    def initialize(
          min: 4,
          max: 8,
          length: nil,
          size: nil,
          key_gens:   [ proc {Random.new.rand(0..100)} ],
          value_gens: [ proc {Random.new.rand} ]
        )
      @length = length || size || (min..max)
      @key_gens = key_gens
      @value_gens = value_gens
      @min = min
      @max = max
    end
    
    def call()
      hash = Hash[
        Array.new(hash_length) do
          [
            @key_gens.sample.call,
            @value_gens.sample.call
          ]
        end
      ]
      while hash.size < hash_length do
        hash = hash.merge(
          {
            @key_gens.sample.call => @value_gens.sample.call
          }
        )
      end
      hash
    end

    private

    def hash_length
      length = Random.new.rand(@length) if @length.is_a? Range
      length = @length if @length.is_a? Integer
      raise "length (size) can't be negative" if length < 0
      length
    end
  end
end
