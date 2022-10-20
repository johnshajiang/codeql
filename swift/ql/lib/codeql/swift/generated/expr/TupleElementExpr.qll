// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr

module Generated {
  class TupleElementExpr extends Synth::TTupleElementExpr, Expr {
    override string getAPrimaryQlClass() { result = "TupleElementExpr" }

    /**
     * Gets the sub expression of this tuple element expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertTupleElementExprToRaw(this)
              .(Raw::TupleElementExpr)
              .getSubExpr())
    }

    /**
     * Gets the sub expression of this tuple element expression.
     */
    final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }

    /**
     * Gets the index of this tuple element expression.
     */
    int getIndex() {
      result = Synth::convertTupleElementExprToRaw(this).(Raw::TupleElementExpr).getIndex()
    }
  }
}
