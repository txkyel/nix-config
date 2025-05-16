// For the most part copied from https://github.com/Mabi19/desktop-shell/blob/b8f3c5ee1aa8c940a73474f5d82a8ee8996522d4/app.ts
// TODO: understand what's going on and simplify
import { App, Astal, Gdk } from "astal/gtk4";
import Gio from "gi://Gio?version=2.0";
import style from "./style.scss";
import Bar from "./widget/Bar";

const windows = new Map<Gdk.Monitor, Astal.Window[]>();

function makeWindowsForMonitor(monitor: Gdk.Monitor) {
  return [Bar(monitor)] as Astal.Window[];
}

App.start({
  css: style,
  main() {
    const display = Gdk.Display.get_default()!;

    for (const monitor of App.get_monitors()) {
      windows.set(monitor, makeWindowsForMonitor(monitor));
    }

    const monitors = display.get_monitors() as Gio.ListModel<Gdk.Monitor>;
    monitors.connect(
      "items-changed",
      (monitorModel, position, idxRemoved, idxAdded) => {
        console.log("monitors changed!", position, idxRemoved, idxAdded);

        const prevSet = new Set(windows.keys());
        const currSet = new Set<Gdk.Monitor>();
        let i = 0;
        while (true) {
          const monitor = monitorModel.get_item(i) as Gdk.Monitor | null;
          i++;
          if (monitor) {
            currSet.add(monitor);
          } else {
            break;
          }
        }

        const removed = prevSet.difference(currSet);
        const added = currSet.difference(prevSet);

        // remove early, before anything else has a chance to break
        for (const monitor of removed) {
          const windowsToRemove = windows.get(monitor) ?? [];
          for (const window of windowsToRemove) {
            window.destroy();
          }
        }

        display.sync();
        console.log(
          "prevSet:",
          Array.from(prevSet).map((mon) => mon.description),
        );
        console.log(
          "currSet:",
          Array.from(currSet).map((mon) => mon.description),
        );
        console.log(
          "removed:",
          Array.from(removed).map((mon) => mon.description),
        );
        console.log(
          "added:",
          Array.from(added).map((mon) => mon.description),
        );

        for (const monitor of added) {
          windows.set(monitor, makeWindowsForMonitor(monitor));
        }
      },
    );
  },
});
