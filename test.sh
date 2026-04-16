corepack enable
corepack prepare pnpm@latest --activate
pnpm install
pnpm build
N8N_DEV_LICENSE_BYPASS=true
NODE_OPTIONS='--max-old-space-size=8192'
pnpm start