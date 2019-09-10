import socket from "./socket"
import {Presence} from "phoenix"

class LiveEventSocket {
    constructor(app_key, options) {
        if (typeof app_key !== 'string') {
            throw "app_key is required"
        }

        this.onCreate = options.onCreate||{}
        this.onUpdate = options.onUpdate||{}
        this.onDelete = options.onDelete||{}
        this.app_key = app_key
        this.socket = socket.init("/socket", {app_key: app_key});
        this.socket.connect();
        this.channel = this.socket.channel("live_event:lobby", () => {
          return {
            app_key: app_key
           }
        });

        this.channel
          .join()
          .receive("error", reason => console.log("error!", reason));

        this.channel.on("create", resp => {
            if (typeof this.onCreate === 'function') {
                this.onCreate.call(this, resp);
            }
        });

        this.channel.on("update", resp => {
            if (typeof this.onUpdate === 'function') {
                this.onUpdate.call(this, resp);
            }
        });

        this.channel.on("delete", resp => {
            if (typeof this.onDelete === 'function') {
                this.onDelete.call(this, resp);
            }
        });
    }
}

let instances = [];

let live_event_socket = {
    init: (app_key, options) => {
        if (typeof instances[app_key] === "undefined") {
            instances[app_key] = new LiveEventSocket(app_key, options)
        }
    }
};

export default live_event_socket