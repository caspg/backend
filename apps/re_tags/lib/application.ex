defmodule ReTags.Application do
  @moduledoc """
  Application for the tag system
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ReTags.Repo, []),
      supervisor(ReTags.Tags.Projections.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: ReTags.Supervisor]
    Supervisor.start_link(children, opts)
  end
end