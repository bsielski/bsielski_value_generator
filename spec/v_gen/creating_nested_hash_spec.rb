require "v_gen/hash_gen"
require "v_gen/int_gen"
require "v_gen/float_gen"
require "v_gen/var_word_gen"
require "v_gen/keyword_gen"
require "v_gen/whatever_gen"

RSpec.describe "creating a hash that can be 2 levels deep" do
  subject (:samples) {
    Array.new(200) {
      root_hash_gen.call
    }
  }

  let (:root_hash_gen) {
    VGen::HashGen.new(
      min: 8,
      max: 8,
      key_gens: [VGen::KeywordGen.new],
      value_gens: [ leaf_hash_gen, non_hash_gen ]
    )
  }

  let (:non_hash_gen) {
    VGen::WhateverGen.new(
      gens: [ VGen::IntGen.new,
              VGen::FloatGen.new,
              VGen::VarWordGen.new,
              VGen::KeywordGen.new
            ]
    )
  }

  let (:leaf_hash_gen) {
    VGen::HashGen.new(
      min: 8,
      max: 8,
      key_gens: [VGen::KeywordGen.new],
      value_gens: [ non_hash_gen ]
    )  }
  
  it "has only size 8 hashes" do
    expect(
      subject.all?{ |hash| hash.size == 8 }
    ).to be true
  end

  it "has only hashes two levels deep" do
    is_not_a_hash = proc {|i| !i.is_a?(Hash)}
    is_max_two_levels = proc do |arr|
      arr.all? do |e|
        is_not_hash = !e.is_a?(Hash)
        is_hash = e.is_a?(Hash)
        has_not_hash_items = is_hash && e.all?(&is_not_a_hash)
        is_not_hash || has_not_hash_items
      end
    end
    expect(
      subject.all?(&is_max_two_levels)
    ).to be true
  end
end
