import { Gtk } from "astal/gtk4";
import { Variable } from "astal";

const time = Variable("").poll(1000, "date +' %H:%M:%S   %d %b, %a'");

const Clock = () => (
  <menubutton>
    <label label={time()} />
    <popover>
      <Gtk.Calendar />
    </popover>
  </menubutton>
);

export default Clock;
