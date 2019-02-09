defmodule Job do
  @derive {Jason.Encoder, only: [:name, :description, :id, :tags, :posted]}
  defstruct name: "", description: "", tags: [], posted: ""


  @word_list ["The", "Scientific", "Revolution", "series", "emergence", "modern", "science", "period", "developments", "mathematics", "physics", "astronomy", "biology"]

  def new(), do: %Job{name: pick_words(2) |> make_string, description: pick_words(5) |> make_string, tags: pick_words(3), posted: ~D[2019-01-22]}

  def pick_words(n) do
    1..n
    |> Enum.map(fn(_i) -> Enum.random(@word_list) end)
  end

  def make_string(words) do
    Enum.map_join(words, &("#{&1}, ")) |> String.trim_trailing(", ")
  end


end
