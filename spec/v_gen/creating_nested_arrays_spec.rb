require "v_gen/array_gen"
require "v_gen/int_gen"
require "v_gen/float_gen"
require "v_gen/var_word_gen"
require "v_gen/keyword_gen"
require "v_gen/whatever_gen"

RSpec.describe "creating an array that can be 2 level deep" do
  subject (:samples) {
    Array.new(300) {
      root_array_gen.call
    }
  }

  let (:root_array_gen) {
    VGen::ArrayGen.new(
      min: 10,
      max: 10,
      gens: [ leaf_array_gen, non_array_gen ]
    )
  }

  let (:non_array_gen) {
    VGen::WhateverGen.new(
      gens: [ VGen::IntGen.new,
              VGen::FloatGen.new,
              VGen::VarWordGen.new,
              VGen::KeywordGen.new
            ]
    )
  }

  let (:leaf_array_gen) {
    VGen::ArrayGen.new(
      min: 10,
      max: 10,
      gens: [ non_array_gen ]
    )
  }
  
  it "has only size 10 arrays" do
    expect(
      subject.all?{ |array| array.size == 10 }
    ).to be true
  end

  it "has only arays two levels deep" do
    is_not_an_array = proc {|i| !i.is_a?(Array)}
    is_max_two_levels = proc do |arr|
      arr.all? do |e|
        is_not_array = !e.is_a?(Array)
        is_array = e.is_a?(Array)
        has_not_array_items = is_array && e.all?(&is_not_an_array)
        is_not_array || has_not_array_items
      end
    end
    expect(
      subject.all?{ |array| is_max_two_levels.(array) }
    ).to be true
  end

  
end
