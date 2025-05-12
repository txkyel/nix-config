import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import Clock from "./components/Clock";
import SysTray from "./components/SysTray";
import AudioControl from "./components/Audio";

const Bar = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox
        cssName="centerbox"
        startWidget={
          <button onClicked="echo hello" hexpand halign={Gtk.Align.START}>
            Welcome to AGS!
          </button>
        }
        centerWidget={
          <box hexpand halign={Gtk.Align.CENTER}>
            <Clock />
          </box>
        }
        endWidget={
          <box hexpand halign={Gtk.Align.END}>
            <AudioControl />
            <SysTray />
          </box>
        }
      />
    </window>
  );
};

export default Bar;
