#!/bin/sh

# shellcheck disable=SC1091
. /etc/profile

JWT_SECRET=$(get_jwt_secret_by_network "${NETWORK}")
echo "${JWT_SECRET}" >"${JWT_PATH}"

post_jwt_to_dappmanager "${JWT_PATH}"

CONFIG="${NETWORK}"
case "${MODE:-normal}" in
  normal)
    ;;
  archive)
    CONFIG="${NETWORK}_archive"
    ;;
  custom)
    CONFIG="/data/custom.cfg"
    ;;
  *)
    echo "[ERROR - entrypoint] Unsupported mode: ${MODE}" >&2
    exit 1
    ;;
esac

echo "[INFO - entrypoint] Starting Nethermind client for network: ${NETWORK}, config: ${CONFIG}"

# shellcheck disable=SC2086
exec /nethermind/nethermind \
  --config "${CONFIG}" \
  --JsonRpc.JwtSecretFile="${JWT_PATH}" \
  --Network.DiscoveryPort="${P2P_PORT}" \
  --Metrics.Enabled=true \
  --Metrics.ExposePort=6060 \
  --Metrics.IntervalSeconds=15 \
  --Network.P2PPort="${P2P_PORT}" ${EXTRA_OPTS}
