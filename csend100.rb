def a001;to_s;end; def a002;to_s;end; def a003;to_s;end; def a004;to_s;end; def a005;to_s;end
def a006;to_s;end; def a007;to_s;end; def a008;to_s;end; def a009;to_s;end; def a010;to_s;end
def a011;to_s;end; def a012;to_s;end; def a013;to_s;end; def a014;to_s;end; def a015;to_s;end
def a016;to_s;end; def a017;to_s;end; def a018;to_s;end; def a019;to_s;end; def a020;to_s;end
def a021;to_s;end; def a022;to_s;end; def a023;to_s;end; def a024;to_s;end; def a025;to_s;end
def a026;to_s;end; def a027;to_s;end; def a028;to_s;end; def a029;to_s;end; def a030;to_s;end
def a031;to_s;end; def a032;to_s;end; def a033;to_s;end; def a034;to_s;end; def a035;to_s;end
def a036;to_s;end; def a037;to_s;end; def a038;to_s;end; def a039;to_s;end; def a040;to_s;end
def a041;to_s;end; def a042;to_s;end; def a043;to_s;end; def a044;to_s;end; def a045;to_s;end
def a046;to_s;end; def a047;to_s;end; def a048;to_s;end; def a049;to_s;end; def a050;to_s;end
def a051;to_s;end; def a052;to_s;end; def a053;to_s;end; def a054;to_s;end; def a055;to_s;end
def a056;to_s;end; def a057;to_s;end; def a058;to_s;end; def a059;to_s;end; def a060;to_s;end
def a061;to_s;end; def a062;to_s;end; def a063;to_s;end; def a064;to_s;end; def a065;to_s;end
def a066;to_s;end; def a067;to_s;end; def a068;to_s;end; def a069;to_s;end; def a070;to_s;end
def a071;to_s;end; def a072;to_s;end; def a073;to_s;end; def a074;to_s;end; def a075;to_s;end
def a076;to_s;end; def a077;to_s;end; def a078;to_s;end; def a079;to_s;end; def a080;to_s;end
def a081;to_s;end; def a082;to_s;end; def a083;to_s;end; def a084;to_s;end; def a085;to_s;end
def a086;to_s;end; def a087;to_s;end; def a088;to_s;end; def a089;to_s;end; def a090;to_s;end
def a091;to_s;end; def a092;to_s;end; def a093;to_s;end; def a094;to_s;end; def a095;to_s;end
def a096;to_s;end; def a097;to_s;end; def a098;to_s;end; def a099;to_s;end; def a100;to_s;end

def test(last)
  i = 0
  while i < last
    a001; a002; a003; a004; a005; a006; a007; a008; a009; a010
    a011; a012; a013; a014; a015; a016; a017; a018; a019; a020
    a021; a022; a023; a024; a025; a026; a027; a028; a029; a030
    a031; a032; a033; a034; a035; a036; a037; a038; a039; a040
    a041; a042; a043; a044; a045; a046; a047; a048; a049; a050
    a051; a052; a053; a054; a055; a056; a057; a058; a059; a060
    a061; a062; a063; a064; a065; a066; a067; a068; a069; a070
    a071; a072; a073; a074; a075; a076; a077; a078; a079; a080
    a081; a082; a083; a084; a085; a086; a087; a088; a089; a090
    a091; a092; a093; a094; a095; a096; a097; a098; a099; a100
    i += 1
  end
end

test(10000)
if RubyVM::MJIT.enabled?
  RubyVM::MJIT.pause
  test(1)
  RubyVM::MJIT.resume
  RubyVM::MJIT.pause
end

before = Process.clock_gettime(Process::CLOCK_MONOTONIC)

if ENV.key?('PERF')
  require 'shellwords'
  pid = Process.spawn('perf', *ENV['PERF'].shellsplit, '-p', Process.pid.to_s)
end

test(500000)

if pid
  Process.kill(:INT, pid)
  Process.wait(pid)
end

after = Process.clock_gettime(Process::CLOCK_MONOTONIC)
puts "==> #{after-before}"
