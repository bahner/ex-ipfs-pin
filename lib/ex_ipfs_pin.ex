defmodule ExIpfsPin do
  @moduledoc """
  Interplanetary Name System commands
  """

  alias ExIpfs.Api

  @doc """
  Add a hash to the pinset.

  ## Parameters

    `path` - IPFS path or list of paths to pin.

  ## Options

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-add

    `recursive`: <bool>, # Recursively pin the object linked to by the specified object(s). Default: true.

  """
  @spec add!(Path.t(), Keyword.t()) :: list | no_return()
  def add!(path, opts \\ [])

  def add!(path, opts) when is_binary(path) do
    Api.post_query("/pin/add?arg=" <> path, query: opts)
    # |> extract_response(["Pins"])
  end

  def add!(path, opts) when is_list(path) do
    Api.post_query("/pin/add?arg=" <> arglist(path), query: opts)
    # |> extract_response(["Pins"])
  end

  @doc """
  Add a hash to the pinset without raising an exception in case of error.

  ## Parameters

    `path` - IPFS path or list of paths to pin.

  ## Options

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-add

    `recursive`: <bool>, # Recursively pin the object linked to by the specified object(s). Default: true.

  ## Returns

    - `{:ok, list()}`: If the pin addition was successful.
    - `{:error, String.t()}`: If there was an error adding the pin.
  """
  @spec add(Path.t(), Keyword.t()) :: {:ok, list()} | {:error, String.t()}
  def add(path, opts \\ []) do
    try do
      {:ok, add!(path, opts)}
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end

  @doc """
  List all the objects pinned to local storage.

  ## Options

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-ls

    `type`: <string>, # The type of pinned keys to list. Can be "direct", "indirect", "recursive", or "all". Default: all.
    `quiet`: <bool>, # Write just hashes of objects.

  """
  @spec ls!(Keyword.t()) :: map | no_return()
  def ls!(opts \\ []) do
    Api.post_query("/pin/ls", query: opts)
    |> has_keys?(["Keys"])
    # |> extract_response(["Keys"])
  end

  @spec ls(Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def ls(opts \\ []) do
    try do
      {:ok, ls!(opts)}
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end

  @doc """
  Remove a pin from the local storage.

  ## Parameters

    `path` - IPFS path or list of paths to unpin.

  ## Options

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-rm

  """
  @spec rm!(Path.t(), Keyword.t()) :: list | no_return()
  def rm!(path, opts \\ [])

  def rm!(path, opts) when is_binary(path) do
    Api.post_query("/pin/rm?arg=" <> path, query: opts)
    # |> extract_response(["Pins"])
  end

  def rm!(path, opts) when is_list(path) do
    Api.post_query("/pin/rm?arg=" <> arglist(path), query: opts)
    # |> extract_response(["Pins"])
  end

  @spec rm(Path.t(), Keyword.t()) :: {:ok, list()} | {:error, String.t()}
  def rm(path, opts \\ []) do
    try do
      {:ok, rm!(path, opts)}
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end

  @doc """
  Update a recursive pin from old path to new path.

  ## Parameters

    `from` - IPFS path to old object to be unpinned.
    `to` - IPFS path to new object to be pinned.

  ## Options

    `unpin`: <bool>, # Remove the old pin. Default: true.

  ## Reference

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-update

  """
  @spec update!(Path.t(), Path.t(), Keyword.t()) :: list | no_return()
  def update!(from, to, opts \\ [unpin: true]) do
    Api.post_query("/pin/update?arg=#{from}&arg=#{to}", query: opts)
    # |> extract_response(["Pins"])
  end

  @doc """
  Update a recursive pin from old path to new path, returns error instead of raising.

  ## Parameters

    `from` - IPFS path to old object to be unpinned.
    `to` - IPFS path to new object to be pinned.

  ## Options

    `unpin`: <bool>, # Remove the old pin. Default: true.

  ## Reference

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-update

  ## Returns

    - `{:ok, list()}`: If the pin update was successful.
    - `{:error, String.t()}`: If there was an error updating the pin.

  """
  @spec update(Path.t(), Path.t(), Keyword.t()) :: {:ok, list()} | {:error, String.t()}
  def update(from, to, opts \\ [unpin: true]) do
    try do
      {:ok, update!(from, to, opts)}
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end

  @doc """
  Verify that recursive pins are complete.

  ## Options

    `verbose`: <bool>, # Also write the hashes of non-broken pins.
    `quiet`: <bool>, # Write just hashes of broken pins.

  ## Reference

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-verify

  """
  @spec verify!(Keyword.t()) :: map | no_return()
  def verify!(opts \\ []) do
    Api.post_query("/pin/verify", query: opts)
    # |> extract_response(["Cid", "Err", "PinStatus"])
  end

  @doc """
  Verify that recursive pins are complete, returns error instead of raising.

  ## Options

    `verbose`: <bool>, # Also write the hashes of non-broken pins.
    `quiet`: <bool>, # Write just hashes of broken pins.

  ## Reference

  https://docs.ipfs.io/reference/http/api/#api-v0-pin-verify

  ## Returns

    - `{:ok, map()}`: If the verification was successful.
    - `{:error, String.t()}`: If there was an error verifying the pins.

  """
  @spec verify(Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def verify(opts \\ []) do
    try do
      {:ok, verify!(opts)}
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end

  # defp extract_single_key_value(response, key) do
  #   case response do
  #     %{^key => value} -> {:ok, value}
  #     _ -> {:error, response}
  #   end
  # end

  defp has_keys?(response, expected_keys) do
    if Enum.all?(expected_keys, &Map.has_key?(response, &1)) do
      response
    else
      {:error, "Invalid response from IPFS API"}
    end
  end

  defp arglist(arglist) do
    arglist
    |> Enum.uniq()
    |> Enum.join("&arg=")
  end
end
