defmodule JobField do
  use MakeEnumerable

  @derive {Jason.Encoder, only: [:value, :type, :options]}
  defstruct value: "", type: "", options: []

  def text_field(value), do: %JobField{value: value, type: "TEXT", options: []}

  def option_field(value, options), do: %JobField{value: value, type: "RADIO", options: options}

  def date_field(value), do: %JobField{value: value, type: "DATE", options: []}

end
