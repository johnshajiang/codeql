import go
import semmle.go.frameworks.Twirp

class InlineTest extends LineComment {
  string tests;

  InlineTest() { tests = this.getText().regexpCapture("\\s*test:(.*)", 1) }

  string getPositiveTest() {
    result = tests.trim().splitAt(",").trim() and not result.matches("!%")
  }

  string getNegativeTest() { result = tests.trim().splitAt(",").trim() and result.matches("!%") }

  predicate hasPositiveTest(string test) { test = this.getPositiveTest() }

  predicate hasNegativeTest(string test) { test = this.getNegativeTest() }

  predicate inNode(DataFlow::Node n) {
    this.getLocation().getFile() = n.getFile() and
    this.getLocation().getStartLine() = n.getStartLine()
  }

  predicate inEntity(Entity e) {
    this.getLocation().getFile() = e.getDeclaration().getFile() and
    this.getLocation().getStartLine() = e.getDeclaration().getLocation().getStartLine()
  }

  predicate inType(Type t) {
    exists(TypeEntity te |
      te.getType() = t and
      this.getLocation().getFile() = te.getDeclaration().getFile() and
      this.getLocation().getStartLine() = te.getDeclaration().getLocation().getStartLine()
    )
  }
}

query predicate passingPositiveTests(string res, string expectation, InlineTest t) {
  res = "PASSED" and
  t.hasPositiveTest(expectation) and
  (
    expectation = "handler" and
    exists(Twirp::ServiceHandler n | t.inEntity(n))
    or
    expectation = "request" and
    exists(Twirp::Request n | t.inNode(n))
    or
    expectation = "ssrfSink" and
    exists(RequestForgery::Sink n | t.inNode(n))
    or
    expectation = "message" and
    exists(Twirp::ProtobufMessage n | t.inType(n))
    or
    expectation = "serviceInterface" and
    exists(Twirp::ServiceInterface n | t.inType(n.getNamedType()))
    or
    expectation = "serviceClient" and
    exists(Twirp::ServiceClient n | t.inType(n))
    or
    expectation = "serviceServer" and
    exists(Twirp::ServiceServer n | t.inType(n))
    or
    expectation = "clientConstructor" and
    exists(Twirp::ClientConstructor n | t.inEntity(n))
    or
    expectation = "serverConstructor" and
    exists(Twirp::ServerConstructor n | t.inEntity(n))
  )
}

query predicate failingPositiveTests(string res, string expectation, InlineTest t) {
  res = "FAILED" and
  t.hasPositiveTest(expectation) and
  (
    expectation = "handler" and
    not exists(Twirp::ServiceHandler n | t.inEntity(n))
    or
    expectation = "request" and
    not exists(Twirp::Request n | t.inNode(n))
    or
    expectation = "ssrfSink" and
    not exists(RequestForgery::Sink n | t.inNode(n))
    or
    expectation = "message" and
    not exists(Twirp::ProtobufMessage n | t.inType(n))
    or
    expectation = "serviceInterface" and
    not exists(Twirp::ServiceInterface n | t.inType(n.getNamedType()))
    or
    expectation = "serviceClient" and
    not exists(Twirp::ServiceClient n | t.inType(n))
    or
    expectation = "serviceServer" and
    not exists(Twirp::ServiceServer n | t.inType(n))
    or
    expectation = "clientConstructor" and
    not exists(Twirp::ClientConstructor n | t.inEntity(n))
    or
    expectation = "serverConstructor" and
    not exists(Twirp::ServerConstructor n | t.inEntity(n))
  )
}

query predicate passingNegativeTests(string res, string expectation, InlineTest t) {
  res = "PASSED" and
  t.hasNegativeTest(expectation) and
  (
    expectation = "!handler" and
    not exists(Twirp::ServiceHandler n | t.inEntity(n))
    or
    expectation = "!request" and
    not exists(Twirp::Request n | t.inNode(n))
    or
    expectation = "!ssrfSink" and
    not exists(RequestForgery::Sink n | t.inNode(n))
    or
    expectation = "!message" and
    not exists(Twirp::ProtobufMessage n | t.inType(n))
    or
    expectation = "!serviceInterface" and
    not exists(Twirp::ServiceInterface n | t.inType(n))
    or
    expectation = "!serviceClient" and
    not exists(Twirp::ServiceClient n | t.inType(n))
    or
    expectation = "!serviceServer" and
    not exists(Twirp::ServiceServer n | t.inType(n))
    or
    expectation = "!clientConstructor" and
    not exists(Twirp::ClientConstructor n | t.inEntity(n))
    or
    expectation = "!serverConstructor" and
    not exists(Twirp::ServerConstructor n | t.inEntity(n))
  )
}

query predicate failingNegativeTests(string res, string expectation, InlineTest t) {
  res = "FAILED" and
  t.hasNegativeTest(expectation) and
  (
    expectation = "!handler" and
    exists(Twirp::ServiceHandler n | t.inEntity(n))
    or
    expectation = "!request" and
    exists(Twirp::Request n | t.inNode(n))
    or
    expectation = "!ssrfSink" and
    exists(RequestForgery::Sink n | t.inNode(n))
    or
    expectation = "!message" and
    exists(Twirp::ProtobufMessage n | t.inType(n))
    or
    expectation = "!serviceInterface" and
    exists(Twirp::ServiceInterface n | t.inType(n))
    or
    expectation = "!serviceClient" and
    exists(Twirp::ServiceClient n | t.inType(n))
    or
    expectation = "!serviceServer" and
    exists(Twirp::ServiceServer n | t.inType(n))
    or
    expectation = "!clientConstructor" and
    exists(Twirp::ClientConstructor n | t.inEntity(n))
    or
    expectation = "!serverConstructor" and
    exists(Twirp::ServerConstructor n | t.inEntity(n))
  )
}
