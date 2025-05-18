import { bind } from "astal";
import { Gdk } from "astal/gtk4";
import AstalWp from "gi://AstalWp";

const audio = AstalWp.get_default()!.audio;

const AudioIcon = ({ endpoint }: { endpoint: AstalWp.Endpoint }) => (
  <box spacing={2}>
    <image iconName={bind(endpoint, "volumeIcon")} pixelSize={16} />
    <label
      label={bind(endpoint, "volume").as((vol) => `${Math.round(vol * 100)}%`)}
    />
  </box>
);

const AudioControl = () => {
  function EndpointWidget({ endpoint }: { endpoint: AstalWp.Endpoint }) {
    return (
      <button
        onScroll={(_1, _2, dy) =>
          endpoint?.set_volume(
            Math.min(Math.max(endpoint.get_volume() - dy / 15, 0), 1),
          )
        }
        onButtonPressed={(_, event) => {
          if (event.get_button() === Gdk.BUTTON_PRIMARY)
            endpoint.set_mute(!endpoint.get_mute());
        }}
      >
        <AudioIcon endpoint={endpoint} />
      </button>
    );
  }

  const speaker = audio.default_speaker;
  const microphone = audio.default_microphone;

  return (
    <box spacing={4}>
      <EndpointWidget endpoint={speaker} />
      <EndpointWidget endpoint={microphone} />
    </box>
  );
};

export default AudioControl;
