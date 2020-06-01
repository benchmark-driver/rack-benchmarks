def a001;nil;end; def a002;nil;end; def a003;nil;end; def a004;nil;end; def a005;nil;end
def a006;nil;end; def a007;nil;end; def a008;nil;end; def a009;nil;end; def a010;nil;end
def a011;nil;end; def a012;nil;end; def a013;nil;end; def a014;nil;end; def a015;nil;end
def a016;nil;end; def a017;nil;end; def a018;nil;end; def a019;nil;end; def a020;nil;end
def a021;nil;end; def a022;nil;end; def a023;nil;end; def a024;nil;end; def a025;nil;end
def a026;nil;end; def a027;nil;end; def a028;nil;end; def a029;nil;end; def a030;nil;end
def a031;nil;end; def a032;nil;end; def a033;nil;end; def a034;nil;end; def a035;nil;end
def a036;nil;end; def a037;nil;end; def a038;nil;end; def a039;nil;end; def a040;nil;end
def a041;nil;end; def a042;nil;end; def a043;nil;end; def a044;nil;end; def a045;nil;end
def a046;nil;end; def a047;nil;end; def a048;nil;end; def a049;nil;end; def a050;nil;end
def a051;nil;end; def a052;nil;end; def a053;nil;end; def a054;nil;end; def a055;nil;end
def a056;nil;end; def a057;nil;end; def a058;nil;end; def a059;nil;end; def a060;nil;end
def a061;nil;end; def a062;nil;end; def a063;nil;end; def a064;nil;end; def a065;nil;end
def a066;nil;end; def a067;nil;end; def a068;nil;end; def a069;nil;end; def a070;nil;end
def a071;nil;end; def a072;nil;end; def a073;nil;end; def a074;nil;end; def a075;nil;end
def a076;nil;end; def a077;nil;end; def a078;nil;end; def a079;nil;end; def a080;nil;end
def a081;nil;end; def a082;nil;end; def a083;nil;end; def a084;nil;end; def a085;nil;end
def a086;nil;end; def a087;nil;end; def a088;nil;end; def a089;nil;end; def a090;nil;end
def a091;nil;end; def a092;nil;end; def a093;nil;end; def a094;nil;end; def a095;nil;end
def a096;nil;end; def a097;nil;end; def a098;nil;end; def a099;nil;end; def a100;nil;end

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
