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


if [ "${1:-}" = "direwolf" ]; then
  has_c=0
  for arg in "$@"; do
    [ "$arg" = "-c" ] && has_c=1 && break
  done

  if [ "$has_c" -eq 0 ]; then
    shift
    set -- direwolf -c "$CONFIG" "$@"
  fi
fi

exec "$@"