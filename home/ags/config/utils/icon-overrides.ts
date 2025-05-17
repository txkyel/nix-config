import { Gio } from "astal";

const OVERRIDES = new Map<string, string>([
  ["corectrl", "corectrl-tray"],
  ["obs", "obs-tray"],
]);

export const get_icon_override = (key: string, fallback: Gio.Icon) => {
  if (OVERRIDES.has(key)) {
    console.log(`Overriding ${key} icon`);
    return new Gio.ThemedIcon({ name: OVERRIDES.get(key) });
  }
  return fallback;
};
