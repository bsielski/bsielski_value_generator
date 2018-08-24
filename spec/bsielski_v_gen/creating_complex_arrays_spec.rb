require "bsielski_v_gen/array_gen"

RSpec.describe "creating a two dimensional 6x6 array of zeroes" do
  subject {
    rows_gen.call
  }

  let (:rows_gen) {
    VGen::ArrayGen.new(
      min: rows_min_size,
      max: rows_max_size,
      gens: [ row_gen ]
    )
  }

  let (:row_gen) {
    VGen::ArrayGen.new(
      min: row_min_size,
      max: row_max_size,
      gens: [ value_gen ]
    )
  }
  
  let (:row_min_size)  { 6 }
  let (:row_max_size)  { 6 }
  let (:rows_min_size) { 6 }
  let (:rows_max_size) { 6 }

  let (:value_gen) {
    proc { 0 }
  }
  
  it "is an 6x6 zeros array" do
    expect(subject)
      .to eq [
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0]
          ]
  end

  describe "but with 4x9 size" do
    let (:row_min_size)  { 9 }
    let (:row_max_size)  { 9 }
    let (:rows_min_size) { 4 }
    let (:rows_max_size) { 4 }

    it "is an 4x9 zeros array" do
      expect(subject)
        .to eq [
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0],
              [0,0,0,0,0,0,0,0,0]
            ]
    end 
  end

  describe "but with \".\"" do
    let (:value_gen) {
      proc { "." }
    }

    it "is an 6x6 dots array" do
      expect(subject)
        .to eq [
              [".",".",".",".",".","."],
              [".",".",".",".",".","."],
              [".",".",".",".",".","."],
              [".",".",".",".",".","."],
              [".",".",".",".",".","."],
              [".",".",".",".",".","."]
            ]
    end
  end
end
