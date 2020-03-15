# frozen_string_literal: true
class HeaderHash < Hash
  def self.new(hash={})
    HeaderHash === hash ? hash : super(hash)
  end

  def initialize(hash={})
    super()
    @names = {}
    hash.each { |k, v| self[k] = v }
  end

  # on dup/clone, we need to duplicate @names hash
  def initialize_copy(other)
    super
    @names = other.names.dup
  end

  def [](k)
    super(k) || super(@names[k.downcase])
  end

  def []=(k, v)
    canonical = k.downcase.freeze
    delete k if @names[canonical] && @names[canonical] != k # .delete is expensive, don't invoke it unless necessary
    @names[canonical] = k
    super k, v
  end

  def delete(k)
    canonical = k.downcase
    result = super @names.delete(canonical)
    result
  end
end

def warmup(loop_count)
  header = HeaderHash.new
  i = 0
  while i < loop_count
    header['foo'] = 'bar'
    i += 1
  end
end

def run(loop_count)
  headers = loop_count.times.map { HeaderHash.new }

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
  warmup(1)
  RubyVM::MJIT.resume
  RubyVM::MJIT.pause
end

run(1000000)
run(1000000)
run(1000000)
run(1000000)
run(1000000)
run(1000000)
run(1000000)
run(1000000)
