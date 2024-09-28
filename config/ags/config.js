import { applauncher } from "./applauncher/applauncher.js"
import { Bar } from "./bar/bar.js"
import { NotificationPopups } from "./notification-popups/notificationPopups.js"

App.config({
    style: "./style.css",
    windows: [
        applauncher,
	Bar(),
        NotificationPopups()
    ],
})
