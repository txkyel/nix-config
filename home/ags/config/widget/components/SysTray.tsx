import { bind } from "astal";
import { Gdk, Gtk } from "astal/gtk4";
import AstalTray from "gi://AstalTray";
import { get_icon_override } from "../../utils/icon-overrides";

const tray = AstalTray.get_default();

// https://github.com/Mabi19/desktop-shell/blob/b8f3c5ee1aa8c940a73474f5d82a8ee8996522d4/bar/tray.tsx
// TODO: understand code and refactor
const TrayItem = ({ item }: { item: AstalTray.TrayItem }) => {
  const popover = Gtk.PopoverMenu.new_from_model(item.menuModel);
  popover.has_arrow = false;
  const button = (
    <menubutton
      popover={popover}
      cssClasses={["tray-item"]}
      tooltipMarkup={bind(item, "tooltipMarkup")}
      setup={(self) => self.insert_action_group("dbusmenu", item.action_group)}
    >
      <image
        cssClasses={["tray-icon"]}
        gicon={bind(item, "gicon").as((icon) =>
          get_icon_override(item.id, icon),
        )}
        pixelSize={20}
      />
    </menubutton>
  ) as Gtk.MenuButton;

  const controller = new Gtk.EventControllerLegacy({
    propagationPhase: Gtk.PropagationPhase.CAPTURE,
  });
  controller.connect("event", (_c, event) => {
    const type = event.get_event_type();

    if (type == Gdk.EventType.BUTTON_PRESS) {
      const button = (event as Gdk.ButtonEvent).get_button();
      if (
        button == Gdk.BUTTON_SECONDARY ||
        (item.is_menu && button == Gdk.BUTTON_PRIMARY)
      ) {
        // do this earlier for less flash-of-invalid-content
        item.about_to_show();
      }
      console.log(item.id);
      console.log(item.title);
      console.log(item.icon_name);
      console.log(item.icon_theme_path);
      console.log(item.icon_pixbuf);
      console.log(item.gicon);
    }

    if (type == Gdk.EventType.BUTTON_RELEASE) {
      const pressEvent = event as Gdk.ButtonEvent;
      const mouseButton = pressEvent.get_button();
      const [_, x, y] = pressEvent.get_position();
      if (pressEvent.get_surface() != button.get_native()?.get_surface()) {
        // this also sometimes captures the click on the popup for some reason
        return false;
      }

      if (mouseButton == Gdk.BUTTON_PRIMARY && !item.is_menu) {
        item.activate(x, y);
      } else if (mouseButton == Gdk.BUTTON_MIDDLE) {
        item.secondary_activate(x, y);
      } else {
        button.popup();
      }
    }
    // Stop processing further.
    return true;
  });
  button.add_controller(controller);

  return button;
};

const SysTray = () => (
  <box cssClasses={["sys-tray"]}>
    {bind(tray, "items").as((items) =>
      items
        .toSorted((a, b) => a.title.localeCompare(b.title))
        .map((item) => <TrayItem item={item} />),
    )}
  </box>
);

export default SysTray;
