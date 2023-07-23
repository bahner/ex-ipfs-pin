# ExIpfsIpns

[![IPNS Unit and integration tests](https://github.com/bahner/ex-ipfs-pin/actions/workflows/testsuite.yaml/badge.svg)](https://github.com/bahner/ex-ipfs-pin/actions/workflows/testsuite.yaml)
[![Coverage Status](https://coveralls.io/repos/github/bahner/ex-ipfs-pin/badge.svg?branch=main)](https://coveralls.io/github/bahner/ex-ipfs-pin?branch=main)

Elixir IPFS pin module. Pinning means making sure files are not garbage collected by the Kubo daemon.
It is possible to register with remote pinning services and make sure CIDs are
kept alive in the IPFS ecosystem.

<!-- ## Usage

```elixir
  iex(1)> ExIpfsIpns.add("k51qzi5uqu5dhxwb3x7bjg8k73tlkaqfugy217mgpf3vpdmoqn9du2qp865ddv")
  {:ok,
    %ExIpfsIpns.Key{
      name: "foo",
      id: "k51qzi5uqu5dhxwb3x7bjg8k73tlkaqfugy217mgpf3vpdmoqn9du2qp865ddv"
    }}
  iex(2)> ExIpfsIpns.Name.publish("/ipfs/QmWGeRAEgtsHW3ec7U4qW2CyVy7eA2mFRVbk1nb24jFyks", key: "foo")
  {:ok,
    %ExIpfsIpns.Name{
      name: "k51qzi5uqu5dhxwb3x7bjg8k73tlkaqfugy217mgpf3vpdmoqn9du2qp865ddv",
      value: "/ipfs/QmWGeRAEgtsHW3ec7U4qW2CyVy7eA2mFRVbk1nb24jFyks"
    }}
```
-->
[ex-ipfs]: https://hex.pm/packages/ex_ipfs "Core Elixir IPFS module"
[ipfs]: https://ipfs.tech/ "Interplanetary File System"
