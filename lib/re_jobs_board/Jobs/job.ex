defmodule Job do
  use MakeEnumerable
#  @derive {Jason.Encoder, only: [:name, :description, :id, :tags, :posted, :website, :owner, :ops]}
  @derive {Jason.Encoder, only: [:id, :name, :bob]} #:topic, :posted, :ops]}
  defstruct name: "", bob: "", topic: "", tags: [], posted: "", website: "", owner: "", ops: []


  def new(), do: %Job{name: JobField.text_field(make_a_string()), bob: JobField.text_field(make_a_string()),topic: JobField.option_field("BOB", ["BILL", "BOB", "SPOON"]), tags: pick_words(3), posted: JobField.date_field(Faker.Date.between(~D[2019-01-01], ~D[2019-04-14])), website: Faker.Pokemon.name(), owner: Owner.new(), ops: []}

  def new(ops), do: %Job{name: pick_words(2) |> make_string, topic: pick_words(5) |> make_string, tags: pick_words(3), posted: Faker.Date.between(~D[2019-01-01], ~D[2019-04-14]), website: Faker.Pokemon.name(), owner: Owner.new(), ops: ops}

  def make_a_string do
    pick_words(2) |> make_string
  end

  def pick_words(n) do
    Faker.Lorem.words(n)
  end

  def make_string(words) do
    Enum.map_join(words, &("#{&1}, ")) |> String.trim_trailing(", ")
  end

  def create_from_params(job, []) do
    job
  end

  def create_from_params(job, params) do
    [{k, v} | tail] = params
    create_from_params(Map.update!(job, String.to_atom(k), fn(_) -> JobField.text_field(v) end), tail)
  end

end
