import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import Clock from "./components/Clock";
import SysTray from "./components/SysTray";

const Bar = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
      margin={0}
    >
      <centerbox
        startWidget={
          <button onClicked="echo hello" halign={Gtk.Align.START}>
            Welcome to AGS!
          </button>
        }
        centerWidget={
          <box halign={Gtk.Align.CENTER}>
            <Clock />
          </box>
        }
        endWidget={
          <box halign={Gtk.Align.END}>
            <SysTray />
          </box>
        }
      />
    </window>
  );
};

export default Bar;
