const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");
import { formatAsByteSize } from "../utils.js";
import network from "./scripts/networkService.js";

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S"'],
});
const time = Variable("", {
  poll: [1000, 'date "+%b %-d %Y"'],
});

const mem_used = Variable("", {
  poll: [1000, "sh -c \"free -m | grep Mem | awk '{print $3}'\""],
});

const cpu_used = Variable("", {
  poll: [
    1000,
    "sh -c \"{ head -n1 /proc/stat;sleep 0.2;head -n1 /proc/stat; } | awk '/^cpu /{u=$2-u;s=$4-s;i=$5-i;w=$6-w}END{print int(0.5+100*(u+s+w)/(u+s+i+w))}'\"",
  ],
});

const generation = Variable("", {
  poll: [3000, 'sh -c "readlink /nix/var/nix/profiles/system | cut -d- -f2"'],
});

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id");
  const workspaces = hyprland.bind("workspaces").as((ws) =>
    ws
      .filter(({ id }) => id > 0) // remove scratchpads, if any
      .sort((a, b) => a.id - b.id) // sort by ID
      .map(({ id, name }) =>
        Widget.Button({
          class_name: "workspaces-button",
          on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
          child: Widget.Label(`${name}`),
          class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
        }),
      ),
  );

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
}

function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    truncate: "end",
    label: hyprland.active.client.bind("title"),
  });
}

function Clock() {
  return Widget.Box({
    class_name: "clock",
    vertical: "true",
    children: [
      Widget.Label({ css: "padding-top: 3px", label: time.bind() }),
      Widget.Label({ label: date.bind() }),
    ],
  });
}

function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(
          (threshold) => threshold <= audio.speaker.volume * 100,
        );

    return `audio-volume-${icons[icon]}-symbolic`;
  }

  const icon = Widget.Icon({
    class_name: `icon-volume${audio.speaker.is_muted ? "-muted" : ""}`,
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  });

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => (audio.speaker.volume = value),
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
  });

  return Widget.Box({
    class_name: "volume",
    vertical: true,
    children: [icon, slider],
  });
}

function BatteryLabel() {
  // const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
  const icon = battery
    .bind("percent")
    .as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`); // 󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹
  const icon_class = battery
    .bind("charged")
    .as((f) =>
      f
        ? "icon-battery-full"
        : battery
            .bind("charging")
            .as((c) => `icon-battery-${c ? "" : "not"}charging`),
    );
  const percentString = battery.bind("percent").as((p) => `${p > 0 ? p : 0}%`);

  return Widget.Box({
    class_name: "battery",
    vertical: true,
    visible: battery.bind("available"),
    children: [
      Widget.Icon({
        class_name: icon_class,
        icon,
      }),
      Widget.Label({
        label: percentString,
      }),
      /*
            Widget.LevelBar({
                widthRequest: 140,
                vpack: "center",
                value,
            }),
	    */
    ],
  });
}

function MemoryUsage() {
  return Widget.Box({
    class_name: "memory",
    vertical: true,
    children: [
      Widget.Label({
        label: "",
        class_name: "icon-memory",
      }),
      Widget.Label({
        label: mem_used.bind().as((m) => `${m} MiB`),
      }),
    ],
  });
}

function DiskSpace(fs, fs_char, fs_class_name) {
  const space_remaining = Variable("", {
    poll: [10000, `sh -c "df -B1 ${fs} | sed -n '2 p' | awk '{print $4}'"`],
  });

  return Widget.Box({
    class_name: `fs-${fs_class_name}`,
    vertical: true,
    children: [
      Widget.Label({
        label: `${fs_char}`,
        class_name: `icon-fs-${fs_class_name}`,
      }),
      Widget.Label({
        label: space_remaining.bind().as((s) => `${formatAsByteSize(s)}`),
      }),
    ],
  });
}

function NetworkTraffic() {
  var up = Widget.Box({
    class_name: "networktraffic-up",
    vertical: true,
    children: [
      Widget.Label({
        label: "󰖩",
        class_name: "icon-network",
      }),
      Widget.Label({
        label: network.bind("up").as((m) => `${formatAsByteSize(m)}/s`),
      }),
    ],
  });
  var down = Widget.Box({
    class_name: "networktraffic-down",
    vertical: true,
    children: [
      Widget.Label({
        label: "󰖩",
        class_name: "icon-network",
      }),
      Widget.Label({
        label: network.bind("down").as((m) => `${formatAsByteSize(m)}/s`),
      }),
    ],
  });

  return Widget.Box({
    class_name: "networktraffic",
    children: [up, down],
  });
}

function CpuUsage() {
  return Widget.Box({
    class_name: "cpu",
    vertical: true,
    children: [
      Widget.Label({
        label: "",
        class_name: "icon-cpu",
      }),
      Widget.Label({
        label: cpu_used.bind().as((m) => `${m}%`),
      }),
    ],
  });
}

function NixOSGeneration() {
  return Widget.Box({
    class_name: "generation",
    vertical: true,
    children: [
      Widget.Label({
        label: "",
        class_name: "icon-generation",
      }),
      Widget.Label({
        label: generation.bind().as((m) => `${m}`),
      }),
    ],
  });
}

function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        class_name: "tray-button",
        child: Widget.Icon({
          class_name: "tray-icon",
          icon: item.bind("icon"),
        }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    class_name: "tray",
    children: items,
  });
}

// layout of the bar
function Left() {
  return Widget.Box({
    vertical: true,
    children: [ClientTitle(), Workspaces()],
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [Clock()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 4,
    children: [
      NetworkTraffic(),
      NixOSGeneration(),
      DiskSpace(
        "/dev/disk/by-uuid/aae47407-820a-49ff-8790-e788a20df65b",
        "󰿠",
        "root",
      ),
      DiskSpace(
        "/dev/disk/by-uuid/a9f3812b-381a-406f-9a01-9838fbf796f9",
        "󰀆",
        "home",
      ),
      CpuUsage(),
      MemoryUsage(),
      Volume(),
      BatteryLabel(),
      SysTray(),
    ],
  });
}

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });
}

export { Bar };
