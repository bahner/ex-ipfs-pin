defmodule ExIpfsPinTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias ExIpfsPin

  describe "add/2" do
    test "returns :ok on successful addition" do
      assert {:ok, _response} = ExIpfsPin.add("Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z", recursive: true)
    end
  end

  describe "add!/2" do
    test "returns a response on successful addition" do
      assert response = ExIpfsPin.add!("Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z", recursive: true)
    end

    test "raises an error on failure" do
      assert_raise RuntimeError, fn ->
        ExIpfsPin.add!("invalid_path", recursive: true)
      end
    end
  end
  describe "ls/1" do
    test "returns :ok on successful listing" do
      assert {:ok, _response} = ExIpfsPin.ls(type: "all")
    end
  end

  describe "ls!/1" do
    test "returns a response on successful listing" do
      assert response = ExIpfsPin.ls!(type: "all")
    end

    test "raises an error on failure" do
      assert_raise RuntimeError, fn ->
        ExIpfsPin.ls!(invalid_option: true)
      end
    end
  end


  describe "rm/2" do
    test "returns :ok on successful removal" do
      assert {:ok, _response} = ExIpfsPin.rm("Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z")
    end
  end

  describe "rm!/2" do
    test "returns a response on successful removal" do
      assert response = ExIpfsPin.rm!("Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z")
    end

    test "raises an error on failure" do
      assert_raise RuntimeError, fn ->
        ExIpfsPin.rm!("invalid_path")
      end
    end
  end

  describe "update/3" do
    test "returns :ok on successful update" do
      assert {:ok, _response} = ExIpfsPin.update("Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z", "Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z", unpin: true)
    end
  end

  describe "update!/3" do
    test "returns a response on successful update" do
      assert response = ExIpfsPin.update!("Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z", "Qmc5gCcjYypU7y28oCALwfSvxCBskLuPKWpK4qpterKC7z", unpin: true)
    end

    test "raises an error on failure" do
      assert_raise RuntimeError, fn ->
        ExIpfsPin.update!("invalid_path", "invalid_path", unpin: true)
      end
    end
  end

  describe "verify/1" do
    test "returns :ok on successful verification" do
      assert {:ok, _response} = ExIpfsPin.verify(verbose: true)
    end
  end

  describe "verify!/1" do
    test "returns a response on successful verification" do
      assert response = ExIpfsPin.verify!(verbose: true)
    end

    test "raises an error on failure" do
      assert_raise RuntimeError, fn ->
        ExIpfsPin.verify!(invalid_option: true)
      end
    end
  end
end
