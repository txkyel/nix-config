import { Gtk } from "astal/gtk4";
import { Variable } from "astal";

const time = Variable("").poll(1000, "date +' %H:%M:%S   %d %b, %a'");

const Clock = () => (
  <menubutton>
    <label label={time()} />
    <popover hasArrow={false}>
      <Gtk.Calendar />
    </popover>
  </menubutton>
);

export default Clock;
