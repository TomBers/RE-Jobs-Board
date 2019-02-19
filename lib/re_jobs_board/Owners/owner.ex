defmodule Owner do

  @derive {Jason.Encoder, only: [:name]}
  defstruct name: ""


  def new(), do: %Owner{name: get_name()}

  def get_name() do
    Enum.random(["Owner_A", "Owner_B", "Owner_C"])
  end

  def match_criteria do
    :name
  end

end
