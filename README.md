# openwa

Setup notes for a self-hosted [OpenWA](https://github.com/rmyndharis/OpenWA) WhatsApp API gateway, plus a "payment received" receipt template.

## Run OpenWA
```
git clone https://github.com/rmyndharis/OpenWA.git
cd OpenWA
docker compose -f docker-compose.dev.yml up -d
```
Dashboard: http://localhost:2785 — read the admin key with `docker exec openwa-api cat /app/data/.api-key`.
Never commit the API key; keep it in an environment variable or a GitHub secret named `OPENWA_API_KEY`.

## Receipt template
`templates/payment-received.json` — create it with `POST /api/sessions/{sessionId}/templates`.
Send it with `scripts/send-template.ps1` (only for payments that were actually received).

> OpenWA is an unofficial WhatsApp client. Avoid bulk/unsolicited messaging to prevent bans.
