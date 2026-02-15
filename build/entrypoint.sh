#!/bin/sh
set -eu

CONFIG="${DW_CONFIG:-/etc/direwolf/direwolf.conf}"

if [ ! -f "$CONFIG" ]; then
  echo "[entrypoint] ERREUR: fichier de configuration introuvable: $CONFIG" >&2
  echo "[entrypoint] Monte un volume, ex: ./config/direwolf.conf:/etc/direwolf/direwolf.conf" >&2
  exit 1
fi

if [ ! -s "$CONFIG" ]; then
  echo "[entrypoint] ERREUR: fichier de configuration vide: $CONFIG" >&2
  exit 1
fi

echo "[entrypoint] OK: config trouvée: $CONFIG"
exec "$@"
