defmodule CanadaSin do
  @moduledoc """
  Documentation for CanadaSin.
  """

  @provinces %{
    0 => [],
    1 => [:NB, :NF, :NS, :PE],
    2 => [:QC],
    3 => [:QC],
    4 => [:ON],
    5 => [:ON],
    6 => [:AB, :MB, :SK, :NT, :NU],
    7 => [:BC, :YU],
    8 => [],
    9 => [:temporary]
  }

  @doc """
  Validates if a SIN matches Canadian's rules

  ## Examples

      iex> CanadaSin.valid? "130 692 544"
      true

      iex> CanadaSin.valid? 130692544
      true

  """
  @spec valid?(integer) :: boolean
  def valid?(number) when is_integer(number), do: valid? Integer.to_string(number)

  @sin_length 9
  @spec valid?(String.t) :: boolean
  def valid?(string) do
    sanitized = sanitize(string)
    if (String.length(sanitized) == @sin_length) do
      rem(compute(sanitized), 10) == 0
    else
      false
    end
  end

  @spec compute(String.t) :: integer
  defp compute(string) do
    numbers = string
    |> String.codepoints
    |> Enum.map(fn (char) -> safe_integer_parse(char) end)
    |> Enum.with_index

    Enum.reduce(numbers, 0, &compute_char/2)
  end

  @multipliers [1, 2, 1, 2, 1, 2, 1, 2, 1]
  @spec compute_char({integer, integer}, integer) :: integer
  defp compute_char({number, index}, acc) do
    multiplier = Enum.at(@multipliers, index)
    acc + sum_of_units(multiplier * number)
  end

  @spec sum_of_units(integer) :: integer
  defp sum_of_units(number) when number < 10, do: number

  defp sum_of_units(number) do
    number
    |> Integer.to_string
    |> String.codepoints
    |> Enum.map(&safe_integer_parse/1)
    |> Enum.reduce(0, fn (value, acc) -> acc + value end)
  end


  @doc """
  Gets the province from the first digit

  ## Examples

      iex> CanadaSin.province "130 692 544"
      [:NB, :NF, :NS, :PE]

      iex> CanadaSin.province 230692544
      [:QC]

  """
  @spec province(integer) :: [atom]
  def province(number) when is_integer(number), do: province(Integer.to_string number)

  @spec province(String.t) :: [atom]
  def province(string) when is_bitstring(string) do
    Map.get @provinces, get_province_code(string)
  end

  @spec get_province_code(String.t) :: integer
  defp get_province_code(string) do
    string
    |> sanitize
    |> String.first
    |> safe_integer_parse
  end

  defp sanitize(string) do
    string
    |> String.trim
    |> String.replace(~r/\D/, "")
  end

  defp safe_integer_parse(number) do
    case Integer.parse(number) do
      {integer, _} -> integer
      :error -> 0
    end
  end
end
