// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.stmt.BraceStmt
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.VarDecl

module Generated {
  class TapExpr extends Synth::TTapExpr, Expr {
    override string getAPrimaryQlClass() { result = "TapExpr" }

    /**
     * Gets the sub expression of this tap expression, if it exists.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertTapExprToRaw(this).(Raw::TapExpr).getSubExpr())
    }

    /**
     * Gets the sub expression of this tap expression, if it exists.
     */
    final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }

    /**
     * Holds if `getSubExpr()` exists.
     */
    final predicate hasSubExpr() { exists(getSubExpr()) }

    /**
     * Gets the body of this tap expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    BraceStmt getImmediateBody() {
      result =
        Synth::convertBraceStmtFromRaw(Synth::convertTapExprToRaw(this).(Raw::TapExpr).getBody())
    }

    /**
     * Gets the body of this tap expression.
     */
    final BraceStmt getBody() { result = getImmediateBody().resolve() }

    /**
     * Gets the var of this tap expression.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    VarDecl getImmediateVar() {
      result =
        Synth::convertVarDeclFromRaw(Synth::convertTapExprToRaw(this).(Raw::TapExpr).getVar())
    }

    /**
     * Gets the var of this tap expression.
     */
    final VarDecl getVar() { result = getImmediateVar().resolve() }
  }
}
