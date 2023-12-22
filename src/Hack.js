function proxy(callback) {
  return new Proxy({}, {
    has() {
      // Elm asserts the existence of object properties before attempting to decode their values.
      // As such, we trick Elm into believing that any looked up property exists.
      // See the json kernel code: https://github.com/elm/json/blob/1.1.3/src/Elm/Kernel/Json.js#L230
      return true
    },

    get(_, prop) {
      return callback(prop)
    }
  })
}

Object.defineProperty(Object.prototype, "__elm_debug_extra__", {
  value: proxy(prop => {
    if (prop === "debugger") {
      debugger
    }

    const getters = {
      time: proxy(name => console.time(name)),
      timeEnd: proxy(name => console.timeEnd(name)),
      performanceMark: proxy(message => performance.mark(message)),
      block: proxy(duration => {
        duration = +duration
        let startTime = new Date().getTime()
        while (new Date().getTime() < startTime + duration) {}
      })
    }

    return getters[prop]
  }),
})
