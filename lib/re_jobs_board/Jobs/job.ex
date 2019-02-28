defmodule Job do
  use MakeEnumerable
#  @derive {Jason.Encoder, only: [:name, :description, :id, :tags, :posted, :website, :owner, :ops]}
  @derive {Jason.Encoder, only: [:id, :name, :topic, :tags, :posted, :location, :required_skils]}
  defstruct name: "", bob: "", topic: "", bill: "", tags: "", posted: "", website: "", owner: "", ops: [], location: [], required_skils: []

  @tags ["A", "B", "C"]
  @topics ["BILL", "BOB", "SPOON"]
  @locations ["Birmingham", "Manchester", "Glasgow"]
  @skills ["Front_End", "Back_End", "Data"]

  def new(), do: %Job{
    name: JobField.text_field(make_a_string()),
    topic: JobField.option_field(Enum.random(@topics), @topics),
    tags: JobField.multiple_choice_field(Enum.random(@tags), @tags),
    posted: JobField.date_field(Faker.Date.between(~D[2019-01-01], ~D[2019-04-14])),
    website: Faker.Pokemon.name(),
    location: JobField.option_field(Enum.random(@locations), @locations),
    required_skils: JobField.multiple_choice_field(Enum.random(@skills), @skills),
    ops: []
  }


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
    create_from_params(Map.update!(job, String.to_atom(k), fn(_) -> v end), tail)
  end

end
