defmodule KV.Store do
  alias :poolboy, as: Poolboy
  alias :eredis, as: Eredis

  def get(key), do: command(["GET", key])

  def set(key, value), do: command(["SET", key, value])

  def setex(key, ttl, value), do: command(["SETEX", key, ttl, value])

  def del(key), do: command(["DEL", key])

  def ttl(key), do: command(["TTL", key]) |> String.to_integer

  def command(args) do
    case Poolboy.transaction(:redis, fn(worker) -> Eredis.q(worker, args, timeout) end) do
      {:ok, result} -> result
      result -> result
    end
  end

  defp timeout, do: Application.get_env(:kv, :redis)[:timeout] || 5000
end
