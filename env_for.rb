# frozen_string_literal: true
require 'perf'
require 'rack/mock'

def run(loop_count, quiet: false)
  before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  i = 0
  while i < loop_count
    Rack::MockRequest.env_for('/', method: 'GET')
    i += 1
  end
  after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "==> #{after-before} (#{loop_count} times)"
end

run(10000, quiet: true)
if RubyVM::MJIT.enabled?
  RubyVM::MJIT.pause
end
Perf.record(count: 5000) do
  run(300000)
end
