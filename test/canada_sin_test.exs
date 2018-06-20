defmodule CanadaSinTest do
  use ExUnit.Case
  doctest CanadaSin

  @valid_sin "130 692 544"
  test "valid sin" do
    assert CanadaSin.valid?(@valid_sin)
  end

  @valid_sin 130692544
  test "valid integer sin" do
    assert CanadaSin.valid?(@valid_sin)
  end

  @valid_sin "130:692;544 and stuff"
  test "valid sin with chars" do
    assert CanadaSin.valid?(@valid_sin)
  end

  @invalid_sin "030 692 544"
  test "invalid sin" do
    assert !CanadaSin.valid?(@invalid_sin)
  end

  @provinces [:NB, :NF, :NS, :PE]
  test "good province" do
    assert CanadaSin.province(@valid_sin) == @provinces
  end

  @provinces []
  test "bad province" do
    assert CanadaSin.province(@invalid_sin) == @provinces
  end
end
