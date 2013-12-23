g = (grunt)->
  r =
    # Start the emulator
    emulate : (target)->
      grunt.task.run ["shell:emulate:#{target}"]