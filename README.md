# Dire Wolf sous Docker

Ce projet permet de faire tourner **Dire Wolf** (TNC logiciel AX.25 / APRS) dans un conteneur **Docker basé sur Alpine Linux**, avec accès audio ALSA et configuration persistante.

La compilation de Dire Wolf est faite depuis les sources officielles.

---

## 📁 Arborescence

```
direwolf-docker/
├─ docker-compose.yml
├─ build/
│  ├─ Dockerfile
│  └─ entrypoint.sh
├─ config/
│  └─ direwolf.conf        # optionnel (auto-généré si absent)
└─ data/
```

---

## 🚀 Fonctionnalités

- Image Docker Alpine légère
- Compilation native de Dire Wolf
- Accès audio ALSA (`/dev/snd`)
- Configuration persistante
- Génération automatique d’un `direwolf.conf` minimal
- Support :
  - KISS TCP
  - VOX / PTT matériel
  - APRS (iGate possible)

---

## 🧱 Prérequis

- Linux (Docker avec accès à `/dev/snd`)
- Docker + Docker Compose
- Carte son fonctionnelle (USB, HAT, etc.)

Vérification audio côté hôte :

```bash
aplay -l
ls /dev/snd
```

---

## 🛠️ Build de l’image

```bash
docker compose build
```

---

## ▶️ Lancement

```bash
docker compose up -d
```

Logs :

```bash
docker logs -f direwolf
```

---

## ⚙️ Configuration

### Variables d’environnement (docker-compose.yml)

| Variable | Description | Exemple |
|--------|------------|---------|
| `TZ` | Fuseau horaire | `Europe/Paris` |

---

### Configuration Dire Wolf

Deux possibilités :

#### 1️⃣ Config automatique (recommandé pour démarrer)

Si `config/direwolf.conf` n’existe pas, le conteneur génère automatiquement un fichier minimal au premier démarrage.

#### 2️⃣ Config personnalisée

Créer/modifier :

```bash
config/direwolf.conf
```

Exemple minimal :

```conf
MYCALL F0XXX-10
ADEVICE plughw:0,0
CHANNELS 1
MODEM 1200
PTT VOX
KISSPORT 8001
```

---

## 🔌 Accès audio

Le conteneur utilise ALSA via :

```yaml
devices:
  - /dev/snd:/dev/snd
```

⚠️ Le nom du device (`plughw:0,0`) dépend de l’ordre des cartes son.

Pour être plus robuste :

```conf
ADEVICE plughw:CARD=Device,DEV=0
```

---

## 🌐 KISS TCP

Par défaut, Dire Wolf ouvre un port KISS TCP :

- Port : `8001`
- Accessible depuis l’hôte : `localhost:8001`

---

## 📡 APRS / iGate (optionnel)

Pour activer un iGate APRS-IS, ajouter dans `direwolf.conf` :

```conf
IGLOGIN F0XXX-10 12345
IGSERVER france.aprs2.net 14580
IGTXVIA 0
```

---

## 🔧 PTT

Méthodes possibles :

- `VOX`
- `CM108`
- `GPIO`
- `RTS` / `DTR`

---

📻 73 & bons paquets AX.25 !
