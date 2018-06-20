# CanadaSin

[![Build Status](https://travis-ci.org/nicklayb/canada_sin.svg?branch=master)](https://travis-ci.org/nicklayb/canada_sin) [![Coverage Status](https://coveralls.io/repos/github/nicklayb/canada_sin/badge.svg?branch=master)](https://coveralls.io/github/nicklayb/canada_sin?branch=master)


Elixir package that validates a Canadian SIN and can get the SIN's province

## Installation

The package can be installed by adding `canada_sin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:canada_sin, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm). Once published, the docs can be found at [https://hexdocs.pm/canada_sin](https://hexdocs.pm/canada_sin).

## Usage
**Note**: The SIN used in example is a fake SIN. It does not belongs to anyone

### Validate

You can use the `CanadaSin.valid?/1` function to validate if the sin matches Canadian rules. You can pass in a string or a number, since first char `0` is not used in Canada.

```elixir
CanadaSin.valid? "130 692 544"
```

You can also pass in an integer directly

```elixir
CanadaSin.valid? 130692544
```

### Get provinces

You can also get valid provinces. Using the `CanadaSin.province/1` will return a list of atom of province codes

**Note**: It does not validate the SIN, it only gives the province matching the first digit. It would return `[]` for an invalid province code.

```elixir
CanadaSin.province ("211 111 111")
[:QC]
```

## References

For references on how the SIN is calculated, you can refer here [http://www.straightlineinternational.com/docs/vaildating_canadian_sin.pdf](http://www.straightlineinternational.com/docs/vaildating_canadian_sin.pdf).
