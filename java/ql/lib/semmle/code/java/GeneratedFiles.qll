/**
 * Provides classes and predicates for working with the most common types of generated files.
 */

import Type
private import semmle.code.java.frameworks.JavaxAnnotations

/** A Java class that is detected as having been generated. */
abstract class GeneratedClass extends Class { }

/**
 * A Java class annotated with a `@Generated` annotation.
 */
class AnnotatedGeneratedClass extends GeneratedClass {
  AnnotatedGeneratedClass() { this.getAnAnnotation() instanceof GeneratedAnnotation }
}

/** A Java class generated by an ANTLR scanner or parser class. */
class AntlrGenerated extends GeneratedClass {
  AntlrGenerated() {
    exists(RefType t | this.getAStrictAncestor() = t |
      // ANTLR v3
      t.hasQualifiedName("org.antlr.runtime", "Lexer") or
      t.hasQualifiedName("org.antlr.runtime", "Parser") or
      t.hasQualifiedName("org.antlr.runtime.tree", "TreeParser") or
      // ANTLR v2
      t.hasQualifiedName("antlr", "TreeParser") or
      t.hasQualifiedName("antlr", "CharScanner") or
      t.hasQualifiedName("antlr", "LLkParser")
    )
  }
}

/** A generated callable is a callable declared in a generated class. */
class GeneratedCallable extends Callable {
  GeneratedCallable() { this.getDeclaringType() instanceof GeneratedClass }
}

/**
 * A file that is detected as having been generated.
 */
abstract class GeneratedFile extends File { }

/**
 * A file detected as generated based on commonly-used marker comments.
 */
library class MarkerCommentGeneratedFile extends GeneratedFile {
  MarkerCommentGeneratedFile() { any(GeneratedFileMarker t).getFile() = this }
}

/**
 * A marker comment that indicates that it is in a generated file.
 */
private class GeneratedFileMarker extends Top {
  GeneratedFileMarker() {
    exists(string msg | msg = this.(JavadocElement).getText() or msg = this.(KtComment).getText() |
      msg.regexpMatch("(?i).*\\bGenerated By\\b.*\\bDo not edit\\b.*") or
      msg.regexpMatch("(?i).*\\bThis (file|class|interface|art[ei]fact) (was|is|(has been)) (?:auto[ -]?)?gener(e?)ated.*") or
      msg.regexpMatch("(?i).*\\bAny modifications to this file will be lost\\b.*") or
      msg.regexpMatch("(?i).*\\bThis (file|class|interface|art[ei]fact) (was|is) (?:mechanically|automatically) generated\\b.*") or
      msg.regexpMatch("(?i).*\\bThe following code was (?:auto[ -]?)?generated (?:by|from)\\b.*") or
      msg.regexpMatch("(?i).*\\bAutogenerated by Thrift.*") or
      msg.regexpMatch("(?i).*\\bGenerated By.*JavaCC.*") or
      msg.regexpMatch("(?i).*\\bGenerated from .* by ANTLR.*")
    )
  }
}
