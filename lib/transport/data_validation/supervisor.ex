defmodule Transport.DataValidation.Supervisor do
  @moduledoc """
  Supervisor for all of data validation aggregates.
  """

  use Supervisor
  alias Transport.DataValidation.Aggregates

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: :data_validation_supervisor)
  end

  def start_project(name) when is_binary(name) do
    Supervisor.start_child(:data_validation_supervisor, [name])
  end

  def init(_arg) do
    supervise([worker(Aggregates.Project, [])], strategy: :simple_one_for_one)
  end
end
