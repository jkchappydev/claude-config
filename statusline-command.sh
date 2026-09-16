#!/bin/sh
# 상태줄 입력(JSON)을 stdin 으로 받아 모델명 · 컨텍스트 사용률 · 예상 비용을 한 줄로 출력
# jq 대신 node 사용 (Windows/macOS 공통으로 별도 설치 없이 동작)
exec node -e '
let raw = "";
process.stdin.on("data", (chunk) => { raw += chunk; });
process.stdin.on("end", () => {
  let data = {};
  try { data = JSON.parse(raw); } catch (e) { /* 입력이 비어있거나 깨진 경우 기본값 사용 */ }

  const model = (data.model && data.model.display_name) || "Unknown";
  const modelId = (data.model && data.model.id) || "";
  const ctx = data.context_window || {};

  // 컨텍스트 사용률
  const usedPct = ctx.used_percentage;
  const contextStr =
    typeof usedPct === "number"
      ? "Context: " + Math.round(usedPct) + "% used"
      : "Context: -";

  // 모델별 100만 토큰당 단가 (입력 / 출력, USD)
  // 위에서부터 순서대로 매칭되므로 구체적인 패턴을 먼저 둔다
  const priceTable = [
    [/claude-(fable|mythos)-5/, 10.0, 50.0],
    [/claude-opus-5/,      5.0, 25.0],
    [/claude-opus-4-[678]/, 5.0, 25.0],
    [/claude-opus-4/,     15.0, 75.0],
    [/claude-sonnet-5/,    2.0, 10.0],
    [/claude-sonnet-4-6/,  3.0, 15.0],
    [/claude-sonnet-4/,    3.0, 15.0],
    [/claude-haiku-4-5/,   1.0,  5.0],
    [/claude-haiku-3-5/,   0.8,  4.0],
    [/claude-haiku/,      0.25,  1.25],
    [/claude-sonnet-3-7/,  3.0, 15.0],
    [/claude-sonnet-3-5/,  3.0, 15.0],
    [/claude-opus-3/,     15.0, 75.0],
  ];
  let [inPrice, outPrice] = [3.0, 15.0];
  for (const [pattern, i, o] of priceTable) {
    if (pattern.test(modelId)) { inPrice = i; outPrice = o; break; }
  }

  // 누적 토큰 기준 예상 비용
  const totalIn = ctx.total_input_tokens || 0;
  const totalOut = ctx.total_output_tokens || 0;
  const cost = (totalIn / 1e6) * inPrice + (totalOut / 1e6) * outPrice;
  const costStr = cost < 0.01 ? "$" + cost.toFixed(4) : "$" + cost.toFixed(2);

  process.stdout.write(`🤖 ${model} | 📊 ${contextStr} | 💰 ${costStr}`);
});
'
