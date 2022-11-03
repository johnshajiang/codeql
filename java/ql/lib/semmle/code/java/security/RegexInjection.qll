/** Provides classes and predicates related to regex injection in Java. */

import java
private import semmle.code.java.dataflow.DataFlow
private import semmle.code.java.frameworks.Regex
//private import semmle.code.java.frameworks.apache.Lang
private import semmle.code.java.regex.RegexFlowModels

/** A data flow sink for untrusted user input used to construct regular expressions. */
abstract class RegexInjectionSink extends DataFlow::ExprNode { }

/** A sanitizer for untrusted user input used to construct regular expressions. */
abstract class RegexInjectionSanitizer extends DataFlow::ExprNode { }

/** A method call that takes a regular expression as an argument. */
private class DefaultRegexInjectionSink extends RegexInjectionSink {
  DefaultRegexInjectionSink() {
    exists(string kind |
      kind.matches([
          "regex-use[]", "regex-use[f1]", "regex-use[f-1]", "regex-use[-1]", "regex-use[0]"
        ]) and
      sinkNode(this, kind)
    )
  }
}

/** A call to a function whose name suggests that it escapes regular expression meta-characters. */
private class RegexSanitizationCall extends RegexInjectionSanitizer {
  RegexSanitizationCall() {
    // original
    // exists(string calleeName, string sanitize, string regexp |
    //   calleeName = this.asExpr().(Call).getCallee().getName() and
    //   sanitize = "(?:escape|saniti[sz]e)" and
    //   regexp = "regexp?"
    // |
    //   calleeName
    //       .regexpMatch("(?i)(" + sanitize + ".*" + regexp + ".*)" + "|(" + regexp + ".*" + sanitize +
    //           ".*)")
    // )
    // without regexp
    exists(string calleeName, string sanitize |
      calleeName = this.asExpr().(Call).getCallee().getName() and
      sanitize = "(?:escape|saniti[sz]e)"
    |
      calleeName.regexpMatch("(?i)(.*" + sanitize + ".*)")
      //calleeName.matches("handleEscapes")
    )
  }
}

/**
 * A call to the `Pattern.quote` method, which gives metacharacters or escape sequences
 * no special meaning.
 */
private class PatternQuoteCall extends RegexInjectionSanitizer {
  PatternQuoteCall() {
    exists(MethodAccess ma, Method m | m = ma.getMethod() |
      ma.getArgument(0) = this.asExpr() and
      m instanceof PatternQuoteMethod
    )
  }
}

/**
 * Use of the `Pattern.LITERAL` flag with `Pattern.compile`, which gives metacharacters
 * or escape sequences no special meaning.
 */
private class PatternLiteralFlag extends RegexInjectionSanitizer {
  PatternLiteralFlag() {
    exists(MethodAccess ma, Method m, Field field | m = ma.getMethod() |
      ma.getArgument(0) = this.asExpr() and
      m.getDeclaringType() instanceof TypeRegexPattern and
      m.hasName("compile") and
      field instanceof PatternLiteralField and
      ma.getArgument(1) = field.getAnAccess()
    )
  }
}
