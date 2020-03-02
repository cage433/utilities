#!/usr/bin/ruby -w

Dir.glob("*/maker-test-output") { |test_output_file|
  started = {}
  finished = {}
  module_ = test_output_file.split('/')[0]
  puts(module_)
  File.readlines(test_output_file).each { |line|
      terms = line.split(28.chr)
      test = "#{terms[1]} #{terms[3]}"
      status = terms[0]
      if status == "START"
        started[test] = 1
      elsif status == "END"
        finished[test] = 1
      end
  }
  #puts("Started #{started.keys}")
  #puts("Finished #{finished.keys}")
  unfinished = started.keys.select{ |key| !finished.has_key?(key) }
  unfinished.each { |u|
    puts "\t#{u}"

  }
  #puts(unfinished)
}
