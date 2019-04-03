defmodule JobField do
  use MakeEnumerable

  @derive {Jason.Encoder, only: [:value, :type, :options]}
  defstruct value: "", type: "", options: []

  def text_field(), do: %JobField{value: "", type: "TEXT", options: []}
  def text_field(value), do: %JobField{value: value, type: "TEXT", options: []}

  def option_field(options), do: %JobField{value: "", type: "OPTION", options: options}
  def option_field(value, options), do: %JobField{value: value, type: "OPTION", options: options}

  def multiple_choice_field(options), do: %JobField{value: "", type: "MULTIPLECHOICE", options: options}
  def multiple_choice_field(value, options), do: %JobField{value: value, type: "MULTIPLECHOICE", options: options}

  def date_field(), do: %JobField{value: Faker.Date.between(~D[2019-01-01], ~D[2019-04-14]), type: "DATE", options: []}
  def date_field(value), do: %JobField{value: value, type: "DATE", options: []}

end
