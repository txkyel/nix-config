import { bind, Variable } from "astal";
import { Gdk } from "astal/gtk4";
import AstalWp from "gi://AstalWp";
import AstalBluetooth from "gi://AstalBluetooth";

// Copied from https://github.com/Abaan404/dotfiles/blob/b1c5c2ac61be32b8e0a1649f0a17e1a2d323e48b/config/ags/windows/Bar.tsx#L200
// TODO: understand and simplify code
const AudioControl = () => {
  const bluetooth = AstalBluetooth.get_default();
  const audio = AstalWp.get_default()?.get_audio();

  function EndpointWidget({
    endpoint,
    glyph,
    spacing,
  }: {
    endpoint?: AstalWp.Endpoint | null;
    glyph: Variable<string>;
    spacing: number;
  }) {
    let volume = Variable("0%");
    let visible = Variable(false);

    if (endpoint) {
      volume = Variable.derive(
        [bind(endpoint, "volume")],
        (volume) => `${Math.ceil(volume * 100)}%`,
      );

      visible = Variable.derive([bind(endpoint, "mute")], (mute) => !mute);
    }

    return (
      <button
        onScroll={(_1, _2, dy) =>
          endpoint?.set_volume(
            Math.min(Math.max(endpoint.get_volume() - dy / 15, 0), 1),
          )
        }
        onButtonPressed={(_, event) => {
          if (event.get_button() === Gdk.BUTTON_PRIMARY)
            endpoint?.set_mute(!endpoint.get_mute());
        }}
        onDestroy={() => {
          volume.drop();
          visible.drop();
        }}
      >
        <box cssClasses={["sink"]} spacing={spacing}>
          <image icon_name={glyph()} />
          <label label={volume()} visible={visible()} />
        </box>
      </button>
    );
  }

  const speaker = audio?.get_default_speaker();
  const microphone = audio?.get_default_microphone();

  let class_names = Variable(["audio", "muted"]);
  let speaker_glyph = Variable("auidio-volume-muted");
  let microphone_glyph = Variable("");

  if (audio) {
    if (speaker) {
      class_names = Variable.derive(
        [bind(bluetooth, "is_connected"), bind(speaker, "mute")],
        (is_connected, mute) => {
          const ret = ["audio"];

          if (is_connected) {
            ret.push("bluetooth");
          }

          if (mute) {
            ret.push("muted");
          }

          return ret;
        },
      );

      speaker_glyph = Variable.derive(
        [bind(speaker, "volume"), bind(speaker, "mute")],
        (volume, mute) => {
          if (mute) return "audio-volume-muted";
          return [
            "audio-volume-low",
            "audio-volume-medium",
            "audio-volume-high",
          ][Math.min(Math.floor(volume * 3), 2)];
        },
      );
    }

    if (microphone) {
      microphone_glyph = Variable.derive([bind(microphone, "mute")], (mute) => {
        if (mute) return "mic-off";
        return "mic-on";
      });
    }
  }

  return (
    <box
      cssClasses={class_names()}
      spacing={4}
      onDestroy={() => {
        speaker_glyph.drop();
        microphone_glyph.drop();
        class_names.drop();
      }}
    >
      <EndpointWidget endpoint={speaker} glyph={speaker_glyph} spacing={6} />
      <EndpointWidget
        endpoint={microphone}
        glyph={microphone_glyph}
        spacing={1}
      />
    </box>
  );
};

export default AudioControl;
