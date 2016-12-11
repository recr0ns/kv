defmodule KV do
  use Application

  alias :eredis, as: Eredis
  alias :poolboy, as: Poolboy

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    pool_options = [
      {:name, {:local, :redis}},
      {:worker_module, Eredis},
      {:size, redis_config[:pool_size]},
      {:max_overflow, redis_config[:max_overflow]}
    ]

    children = [
      Poolboy.child_spec(:redis, pool_options, Keyword.take(redis_config, [:port, :host, :database, :timeout]))
    ]

    opts = [strategy: :one_for_one, name: KV.Supervisor]

    Supervisor.start_link(children, opts)
  end

  defp redis_config, do: Application.get_env(:kv, :redis)
end
