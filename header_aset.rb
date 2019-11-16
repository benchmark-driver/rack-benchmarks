# frozen_string_literal: true
require 'perf'
require 'rack/utils'

def warmup(loop_count)
  header = Rack::Utils::HeaderHash.new
  i = 0
  while i < loop_count
    header['foo'] = 'bar'
    i += 1
  end
end

def run(loop_count)
  headers = loop_count.times.map { Rack::Utils::HeaderHash.new }

  before = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  i = 0
  while i < loop_count
    header = headers[i]
    header['Content-Type'] = 'text/html;charset=utf-8'
    header['Content-Length'] = '25'
    header['X-XSS-Protection'] = '1; mode=block'
    header['X-Content-Type-Options'] = 'nosniff'
    header['X-Frame-Options'] = 'SAMEORIGIN'
    i += 1
  end
  after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "==> #{after-before} (#{loop_count} times)"
end

warmup(10000)
if RubyVM::MJIT.enabled?
  RubyVM::MJIT.pause
end
Perf.record(count: 5000) do
  run(500000)
end
