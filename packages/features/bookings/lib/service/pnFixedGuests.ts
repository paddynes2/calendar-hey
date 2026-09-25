// PN-FIX-4: event types that always carry a fixed guest, whatever the booker enters.
// EventType 11 = "chat": Wesley is on every Chat booking alongside Patrick.
// Inputs are `unknown` on purpose: the booking handler's inferred types are huge, and
// comparing against them stalled the trpc type-check for 15+ minutes on Vercel.
const PN_ALWAYS_INVITE: Record<number, string[]> = { 11: ["wesley@autospark.ai"] };

export function pnWithFixedGuests(eventTypeId: unknown, bookerEmail: unknown, guests: unknown): string[] {
  const out: string[] = [];
  if (Array.isArray(guests)) {
    for (const g of guests) {
      if (typeof g === "string") out.push(g);
    }
  }
  const extras = typeof eventTypeId === "number" ? PN_ALWAYS_INVITE[eventTypeId] || [] : [];
  const booker = typeof bookerEmail === "string" ? bookerEmail.toLowerCase() : "";
  for (const extra of extras) {
    const lower = extra.toLowerCase();
    if (lower === booker) continue;
    if (out.some((g) => g.toLowerCase() === lower)) continue;
    out.push(extra);
  }
  return out;
}
