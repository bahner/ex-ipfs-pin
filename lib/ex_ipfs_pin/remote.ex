defmodule ExIpfsPin.Remote do
  @moduledoc """
  ExIpfsPin.Key module handles creating, listing, renaming, and removing IPNS keys.

  Keys are what generates an IPNS name. The key is a cryptographic key pair, and the name is a hash of the public key. The name is what is used to resolve the IPNS name.
  """
  alias ExIpfs.Api

  @enforce_keys [:cid, :name, :status]
  defstruct [:cid, :name, :status]

  @typedoc """
   Struct of reply from a remote pin operation.
  """
  @type t :: %__MODULE__{
          cid: binary(),
          name: binary(),
          status: binary()
        }

  defp new!(response) do
    %__MODULE__{
      cid: response["Cid"],
      name: response["Name"],
      status: response["Status"]
    }
  end

  @doc """
  Pin a hash to a remote service.

  ## Parameters

    `cid` - IPFS hash to pin.
    `service` - Remote service to pin to.

  ## Options

  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-pin-remote-add

    `name` - An optional name for the pin. If no name is provided, the default name is the base32-encoded CID.
    `background` - If true, pinning will not be waited for to complete. Default: false.

  """
  @spec add!(binary, binary, list) :: t() | Api.error_response()
  def add!(cid, service, opts \\ []) do
    Api.post_query("/pin/remote/add?arg=" <> cid <> "&service=" <> service, query: opts)
    |> new!()
  end
end
