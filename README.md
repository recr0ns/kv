# KV

[E]Redis wrapper

## Installation

  1. Add `kv` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:kv, github: "recr0ns/kv"}]
    end
    ```

  2. Ensure `kv` is started before your application:

    ```elixir
    def application do
      [applications: [:kv]]
    end
    ```

  3. Config sample

    ```elixir
    config :kv, :redis,
      pool_size: 10,
      max_overflow: 5,
      host: '127.0.0.1',
      port: 6379,
      database: 1,
      timeout: 5000
    ```
