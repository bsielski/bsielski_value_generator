# bsielski Value Generator

This gem can:
  - create random int, float, string, and symbols
  - create a random value of random type
  - create an array of random values
  - create a hash of random key and values

## Why to use it?

Who knows. I have made it when I was creating a code with functional style and was working mainly with hashes as a data containers and I wanted some configurable generator of random hashes for my unit tests.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bsielski_value_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bsielski_value_generator

## Usage

Reqiure proper class.

```ruby
require "v_gen/int_gen"
```

Use it.

```ruby
random_int = VGen::IntGen.new.call

# or

int_gen = VGen::IntGen.new
random_int = int_gen.call
```

All generators have just one public method: `#call`.



## API



### VGen::IntGen

```ruby
require "v_gen/int_gen"
```

#### Class Public Methods

##### `new(range=(0..10)) → new_generator`

*range* is the range from which the number is randomly generated.

#### Public Instance Methods

##### `call → new_int`



### VGen::FloatGen

```ruby
require "v_gen/float_gen"
```

#### Class Public Methods

##### `new(range=(-10..10)) → new_generator`

See VGen::IntGen.new for details about *range* argument.

#### Public Instance Methods

##### `call → new_float`



### VGen::LetterGen

```ruby
require "v_gen/letter_gen"
```

#### Class Public Methods

##### `new(only: (("A".."Z").to_a + ("a".."z").to_a), except: []) → new_generator`

*only* an array (or range) of objects from which one randomly chosen is returned.

*except* an array (or range) that is substracted from *only* array (range).

#### Public Instance Methods

##### `call → new_object`



### VGen::LowerLetterGen

```ruby
require "v_gen/lower_letter_gen"
```

#### Class Public Methods

##### `new(only: ("A".."Z"), except: []) → new_generator`

See VGen::LetterGen.new for details about *only* and *except* arguments.

The object in *only* and *except* arrays or ranges must respond to `#downcase` method.

#### Public Instance Methods

##### `call → new_lowercased_object`



#### Example

```ruby
lower_letter_gen = VGen::LowerLetterGen.new(only: ("A".."Z"))
lower_letter_gen.call # => "j"
lower_letter_gen.call # => "e"
```

### VGen::UpperLetterGen

```ruby
require "v_gen/upper_letter_gen"
```

#### Class Public Methods

##### `new(only: ("A".."Z"), except: []) → new_generator`

See VGen::LetterGen.new for details about *only* and *except* arguments.

The object in *only* and *except* arrays or ranges must respond to `#upcase` method.

#### Public Instance Methods

##### `call → new_uppercased_object`

#### Example

```ruby
upper_letter_gen = VGen::UpperLetterGen.new(only: ("A".."Z"))
upper_letter_gen.call # => "I"
upper_letter_gen.call # => "D"
```



### VGen::TypicalLetterGen

```ruby
require "v_gen/typical_letter_gen"
```

#### Class Public Methods

##### `new → new_generator`

#### Public Instance Methods

##### `call → new_letter`

It returns a random lowercased letter with taking into account the frequency of occurrence in English language.



### VGen::VarWordGen

```ruby
require "v_gen/var_word_gen"
```

#### Class Public Methods

##### `new(letter_gen: TypicalLetterGen.new, lenght: (4..9), except: []) → new_generator`

*letter_gen* is a generator used to creating a letters for words.

*length* possible word length as a range.

*except* words forbidden to generate.

#### Public Instance Methods

##### `call(lenght: (4..9), except: []) → new_random_word`

It returns a random lowercased word sometimes with underscore in the middle.



### VGen::KeywordGen

```ruby
require "v_gen/keyword_gen"
```

#### Class Public Methods

##### `new(word_gen: VarWordGen.new) → new_generator`

*word_gen* is a generator used to creating a word that will be converted to a symbol.

#### Public Instance Methods

##### `call → new_random_word`

It returns a random lowercased word sometimes with underscore in the middle.



### VGen::ArrayGen

```ruby
require "v_gen/array_gen"
```

#### Class Public Methods

##### `new(min: 4, max: 8, gens: [proc {Random.new.rand}]) → new_generator`

*min* is a minimum size of a generated arrays.

*max* is a maximum size of a generated arrays.

*gens* are generators used randomly to generate values.

#### Public Instance Methods

##### `call → new_random_word`

It returns an array of  random values.



### VGen::HashGen

```ruby
require "v_gen/hash_gen"
```

#### Class Public Methods

##### `new(min: 4, max: 8, key_gens: [proc {Random.new.rand(0..100)}], value_gens: [proc {Random.new.rand}]) → new_generator`

*min* is a minimum size of a generated arrays.

*max* is a maximum size of a generated arrays.

*key_gens* are generators used randomly to generate keys.

*value_gens* are generators used randomly to generate values.

#### Public Instance Methods

##### `call → new_random_word`

It returns a hash of random keys and values.






## To do features

- Better API
- Some easy to use generators with default parameters

## To do features

- Better API
- Some easy to use generators with default parameters

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
