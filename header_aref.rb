# frozen_string_literal: true
require 'perf'
require 'rack/utils'

def run(loop_count, quiet: false)
  header = Rack::Utils::HeaderHash.new

  before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  i = 0
  while i < loop_count
    header['Content-Type']
    i += 1
  end
  after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "==> #{after-before} (#{loop_count} times)" unless quiet
end

run(10000, quiet: true)
if RubyVM::MJIT.enabled?
  RubyVM::MJIT.pause
end
Perf.record(count: 5000) do
  run(8000000)
end
