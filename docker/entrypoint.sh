#!/bin/sh
set -eu

config_file=/usr/share/nginx/html/runtime-config.js
temp_file="${config_file}.tmp"

printf 'window.__PINDOU_CONFIG__ = ' > "$temp_file"
jq -cn \
  --arg supabaseUrl "${SUPABASE_URL:-}" \
  --arg supabaseAnonKey "${SUPABASE_ANON_KEY:-}" \
  --arg turnstileSiteKey "${TURNSTILE_SITE_KEY:-}" \
  '{SUPABASE_URL:$supabaseUrl,SUPABASE_ANON_KEY:$supabaseAnonKey,TURNSTILE_SITE_KEY:$turnstileSiteKey}' \
  >> "$temp_file"
printf ';\n' >> "$temp_file"
mv "$temp_file" "$config_file"

exec nginx -g 'daemon off;'
