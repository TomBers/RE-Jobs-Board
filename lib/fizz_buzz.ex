defmodule FizzBuzz do

  def fizzbuzz(number) do
    numbers = Stream.iterate(1, &(&1 + 1))
    fizz    = Stream.cycle(["", "", "fizz"])
    buzz    = Stream.cycle(["", "", "", "", "buzz"])
    result =
      Stream.zip(fizz, buzz)
      |> Stream.zip(numbers)
      |> Stream.map( fn
        {{"", ""}, number}              -> number
        {{fizzword, buzzword}, _number} -> fizzword <> buzzword
      end)
    result |> Stream.take(number) |> Enum.each(&IO.puts/1)
  end

  def test_stream do
    1..1000000
#    |> Stream.filter(fn(x) -> rem(x, 2) == 0 end)
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Stream.map(&("This is number #{&1}"))
    |> Enum.take(2)
  end

  def test_iterate do
    Stream.iterate(0, fn(x) -> x + (Enum.take_random(-5..5, 1) |> List.first)  end) |> Stream.take(6) |> Enum.each(&IO.puts/1)
  end

  def test_cycle do
    Stream.cycle(1..48) |> Stream.take(15) |> Enum.each(&IO.puts/1)
  end

  def simple(number) do
    1..number
    |> Enum.map(fn(x) -> get_val(x) end)
    |> IO.inspect
  end

  defp get_val(x) when rem(x, 3) == 0 and rem(x, 5) == 0 do
    "Fizz Buzz"
  end

  defp get_val(x) when rem(x, 3) == 0 do
    "Fizz"
  end

  defp get_val(x) when rem(x, 5) == 0 do
    "Buzz"
  end

  defp get_val(x) do
    x
  end


end
