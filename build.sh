# 1. Instalar dependências
pnpm install

# 2. Gerar o parser do codemirror (necessário antes do build)
pnpm --filter=@n8n/codemirror-lang-html run grammar:build

# 3. Buildar a aplicação
pnpm build:n8n

version="2.16.1"
docker build \
  -t ghcr.io/adfastltda/n8n_pro/n8n:$version \
  -t ghcr.io/adfastltda/n8n_pro/n8n:latest \
  -f docker/images/n8n/Dockerfile \
  --build-arg NODE_VERSION=24.14.1 \
  --build-arg N8N_VERSION=$version \
  --build-arg N8N_RELEASE_TYPE=stable \
  --build-arg N8N_DEV_LICENSE_BYPASS=true \
  --build-arg NODE_OPTIONS="--max-old-space-size=8192" \
  .

# # 5. Buildar a imagem runners (opcional)
docker build \
  -t ghcr.io/adfastltda/n8n_pro/runners:$version \
  -t ghcr.io/adfastltda/n8n_pro/runners:latest \
  -f docker/images/runners/Dockerfile \
  --build-arg NODE_VERSION=24.14.1 \
  --build-arg N8N_VERSION=$version \
  --build-arg N8N_RELEASE_TYPE=stable \
  .

docker push ghcr.io/adfastltda/n8n_pro/n8n:$version
docker push ghcr.io/adfastltda/n8n_pro/n8n:latest
docker push ghcr.io/adfastltda/n8n_pro/runners:$version
docker push ghcr.io/adfastltda/n8n_pro/runners:latest