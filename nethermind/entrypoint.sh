#!/bin/sh

set_jwt_path() {
  CLIENT=$1
  echo "Using $CLIENT JWT"
  JWT_PATH="/security/$CLIENT/jwtsecret.hex"
}

set_network_specific_config() {
  CONSENSUS_DNP=$1
  P2P_PORT=$2

  echo "[INFO - entrypoint] Initializing $NETWORK specific config for client"

  # If consensus client is prysm-prater.dnp.dappnode.eth --> CLIENT=prysm
  CLIENT=$(echo "$CONSENSUS_DNP" | cut -d'.' -f1 | cut -d'-' -f1)

  set_jwt_path "$CLIENT"

}

case "$NETWORK" in
"gnosis") set_network_specific_config "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_GNOSIS" 31404 ;;
"holesky") set_network_specific_config "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_HOLESKY" 31804 ;;
"mainnet") set_network_specific_config "$_DAPPNODE_GLOBAL_CONSENSUS_CLIENT_MAINNET" 30404 ;;
*)
  echo "Unsupported network: $NETWORK"
  exit 1
  ;;
esac

# Print the jwt to the dappmanager
JWT=$(cat "${JWT_PATH}")
curl -X POST "http://my.dappnode/data-send?key=jwt&data=${JWT}"

exec /nethermind/nethermind \
  --config "${NETWORK}" \
  --JsonRpc.JwtSecretFile="${JWT_PATH}" \
  --Network.DiscoveryPort="${P2P_PORT}" \
  --Network.P2PPort="${P2P_PORT}" \
  "${EXTRA_OPTS}"
