#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="${YGGDRASIL_ROOT:-$(pwd)}"
BRANCH="galatea/sample-$(date +%Y%m%d%H%M%S)"
GITHUB_REMOTE="${GITHUB_REMOTE:-origin}"
TOKEN="${GITHUB_TOKEN:-}"

cd "$REPO_DIR"
git checkout -b "$BRANCH"

if [ -x "scripts/agentes/galatea-fabrica-agentes.sh" ]; then
  bash scripts/agentes/galatea-fabrica-agentes.sh "agent-sample" "Agente de ejemplo" "sample"
else
  mkdir -p agentes/agent-sample
  cat > agentes/agent-sample/DISEÑO.md <<'MD'
# agent-sample
## Rol
Ejemplo creado por Galatea
MD
  cat > scripts/agent-sample.sh <<'SH'
#!/usr/bin/env bash
echo "agent-sample executed"
SH
  chmod +x scripts/agent-sample.sh
fi

git add -A
git commit -m "chore(galatea): add agent-sample (auto)"
git push "$GITHUB_REMOTE" "$BRANCH"

if [ -z "$TOKEN" ]; then
  echo "Branch pushed: $BRANCH. Set GITHUB_TOKEN to auto-create PR."
  exit 0
fi

REPO_API=$(git remote get-url "$GITHUB_REMOTE" | sed -E 's#(git@github.com:|https://github.com/)([^/]+/[^.]+)(.git)?#https://api.github.com/repos/\2#')
PR_TITLE="galatea: add agent-sample (auto)"
PR_BODY="Auto-generated sample agent by Galatea. Please review."

curl -s -X POST "$REPO_API/pulls" \
  -H "Authorization: token $TOKEN" \
  -H "Content-Type: application/json" \
  -d "$(jq -nc --arg t "$PR_TITLE" --arg b "$PR_BODY" --arg h "$BRANCH" --arg base "main" '{title:$t,body:$b,head:$h,base:$base}')" \
  | jq -r '.html_url'
