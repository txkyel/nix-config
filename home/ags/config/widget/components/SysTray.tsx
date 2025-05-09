import { bind } from "astal";
import Tray from "gi://AstalTray";

const tray = Tray.get_default();

const SysTray = () => (
  <box className="SysTray">
    {bind(tray, "items").as((items) => {
      return items.map((item) => {
        return (
          <menubutton
            tooltipMarkup={bind(item, "tooltipMarkup")}
            usePopover={false}
            actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
            menuModel={bind(item, "menuModel")}
          >
            <icon gicon={bind(item, "gicon")} />
          </menubutton>
        );
      });
    })}
  </box>
);

export default SysTray;
