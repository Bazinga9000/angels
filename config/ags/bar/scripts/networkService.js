class NetworkTrafficService extends Service {
    static {
        Service.register(
	    this,
	    {},
	    { 'up': ["float", "r"], 'down': ["float", "r"] },
        )
    }
     
    up = 0
    down = 0
    
    get up() { return this.up; }
    get down() { return this.down; }
    constructor() {
        super();
	
        Utils.subprocess(
            ["bash", "-c", "~/.config/ags/bar/scripts/traffic.sh"],
            (output) => {
                var o = output.split(" ")
		this.down = Number(o[0])
		this.up = Number(o[1])
	        this.emit('changed')
		this.notify('up')
		this.notify('down')
            }
        )
    }
}

const s = new NetworkTrafficService

export default s
