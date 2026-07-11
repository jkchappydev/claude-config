#!/bin/sh
input=$(cat)

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')

# Context usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_str=""
if [ -n "$used_pct" ]; then
  context_str=$(printf "Context: %.0f%% used" "$used_pct")
else
  context_str="Context: -"
fi

# Cost estimation based on model pricing (USD per 1M tokens)
# Prices: input / output
model_id=$(echo "$input" | jq -r '.model.id // ""')
case "$model_id" in
  *claude-opus-4*)       input_price=15.0;  output_price=75.0  ;;
  *claude-sonnet-4*)     input_price=3.0;   output_price=15.0  ;;
  *claude-haiku-3-5*)    input_price=0.8;   output_price=4.0   ;;
  *claude-haiku*)        input_price=0.25;  output_price=1.25  ;;
  *claude-sonnet-3-7*)   input_price=3.0;   output_price=15.0  ;;
  *claude-sonnet-3-5*)   input_price=3.0;   output_price=15.0  ;;
  *claude-opus-3*)       input_price=15.0;  output_price=75.0  ;;
  *)                     input_price=3.0;   output_price=15.0  ;;
esac

total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

cost=$(echo "$total_input $total_output $input_price $output_price" | awk '{
  cost = ($1 / 1000000 * $3) + ($2 / 1000000 * $4)
  if (cost < 0.01) printf "$%.4f", cost
  else printf "$%.2f", cost
}')

printf "🤖 %s | 📊 %s | 💰 %s" "$model" "$context_str" "$cost"
