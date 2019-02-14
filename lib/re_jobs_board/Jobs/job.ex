defmodule Job do

  @derive {Jason.Encoder, only: [:name, :description, :id, :tags, :posted, :website]}
  defstruct name: "", description: "", tags: [], posted: "", website: ""


  def new(), do: %Job{name: pick_words(2) |> make_string, description: pick_words(5) |> make_string, tags: pick_words(3), posted: Faker.Date.between(~D[2000-01-01], ~D[2019-02-22]), website: Faker.Pokemon.name()}

  def pick_words(n) do
    Faker.Lorem.words(n)
  end

  def make_string(words) do
    Enum.map_join(words, &("#{&1}, ")) |> String.trim_trailing(", ")
  end


end
