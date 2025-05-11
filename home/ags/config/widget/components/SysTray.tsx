import { bind } from "astal";
import { hook } from "astal/gtk4";
import AstalTray from "gi://AstalTray";

const tray = AstalTray.get_default();

const TrayItem = ({ item }: { item: AstalTray.TrayItem }) => {
  return (
    <menubutton
      cssClasses={["tray-item"]}
      tooltipMarkup={bind(item, "tooltipMarkup")}
      menuModel={bind(item, "menuModel")}
      setup={(self) => {
        hook(self, item, "notify::action-group", () =>
          self.insert_action_group("dbusmenu", item.action_group),
        );
        self.insert_action_group("dbusmenu", item.action_group);
      }}
    >
      <image cssClasses={["tray-icon"]} gicon={bind(item, "gicon")} />
    </menubutton>
  );
};

const SysTray = () => (
  <box cssClasses={["sys-tray"]}>
    {bind(tray, "items").as((items) =>
      items.map((item) => <TrayItem item={item} />),
    )}
  </box>
);

export default SysTray;
