# Nethermind (Execution Client)

Welcome to the Nethermind Execution Client.

There are now two RPC APIs in Execution Clients:

1. **Querying API**: Use this endpoint to query transactions on your node and connect to it with your web3 wallet.
2. **Engine API**: Use this endpoint to connect your Beacon Chain (Consensus Layer) client.

If your Execution Client is not connected to a Consensus Layer client, you won't be able to use it to query the blockchain, nor will you be able to connect your wallet to it!

## Archive mode on Nethermind 2.0

Select **Archive** in the setup wizard to use the network's `_archive` configuration and its sync and storage settings.

To serve historical state from genesis, start with a fresh data volume and sync from genesis. Switching an already synced full node to Archive does not recreate earlier state. An existing Patricia archive keeps using its Patricia database. See the [Nethermind archive guide](https://docs.nethermind.io/fundamentals/archive-nodes/) for other storage layouts, which can be configured through `EXTRA_OPTS`.
