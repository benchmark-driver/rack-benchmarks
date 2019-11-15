# frozen_string_literal: true
require 'rack/mock'

def run(loop_count)
  before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  i = 0
  while i < loop_count
    Rack::MockRequest.env_for('/', method: 'GET')
    i += 1
  end
  after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "==> #{after-before} (#{loop_count} times)"
end

run(10000)
if RubyVM::MJIT.enabled?
  RubyVM::MJIT.pause
end
run(500000)
