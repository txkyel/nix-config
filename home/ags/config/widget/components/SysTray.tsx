import { bind } from "astal";
import { hook } from "astal/gtk4";
import Tray from "gi://AstalTray";

const tray = Tray.get_default();

const SysTray = () => (
  <box>
    {bind(tray, "items").as((items) =>
      items.map((item) => (
        <menubutton
          tooltipMarkup={bind(item, "tooltipMarkup")}
          menuModel={bind(item, "menuModel")}
          setup={(self) => {
            hook(self, item, "notify::action-group", () =>
              self.insert_action_group("dbusmenu", item.action_group),
            );
            self.insert_action_group("dbusmenu", item.action_group);
          }}
        >
          <image gicon={bind(item, "gicon")} />
        </menubutton>
      )),
    )}
  </box>
);

export default SysTray;
