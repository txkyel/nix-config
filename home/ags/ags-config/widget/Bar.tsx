import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import SysTray from "./components/SysTray";
import Time from "./components/Time";

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
        centerWidget={undefined}
        endWidget={
          <box halign={Gtk.Align.END}>
            <SysTray />
            <Time />
          </box>
        }
      />
    </window>
  );
};

export default Bar;
