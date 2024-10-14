import { applauncher } from "./applauncher/applauncher.js"
import { Bar } from "./bar/bar.js"

App.config({
    style: "./style.css",
    windows: [
        applauncher,
        Bar(0),
        Bar(1),
    ],
})
