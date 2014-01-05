module.exports = {
  run: function() {
    return {
      done: function(s,f) {
        s()
      }
    }
  }
}