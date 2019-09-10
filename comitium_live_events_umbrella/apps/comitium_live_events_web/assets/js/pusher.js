import socket from "./socket"

class Pusher {
    constructor(app_key) {
        if (typeof app_key !== 'string') {
            throw "app_key is required"
        }

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
    }

    create(payload) {
        this.channel
            .push("create", payload)
            .receive("error", reason => console.log("push error", reason))
    }

    update(payload) {
        this.channel
            .push("update", payload)
            .receive("error", reason => console.log("push error", reason))
    }

    delete(payload) {
        this.channel
            .push("delete", payload)
            .receive("error", reason => console.log("push error", reason))
    }

}

let instance = null;

let pusher = {
    create: (app_key, payload) => {
        if (instance === null) {
            instance = new Pusher(app_key)
        }

        instance.create(payload);
    },
    update: (app_key, payload) => {
        if (instance === null) {
            instance = new Pusher(app_key)
        }

        instance.update(payload);
    },
    delete: (app_key, payload) => {
        if (instance === null) {
            instance = new Pusher(app_key)
        }

        instance.delete(payload);
    }
};

export default pusher