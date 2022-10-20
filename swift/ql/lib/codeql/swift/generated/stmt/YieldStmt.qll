// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.stmt.Stmt

module Generated {
  class YieldStmt extends Synth::TYieldStmt, Stmt {
    override string getAPrimaryQlClass() { result = "YieldStmt" }

    /**
     * Gets the `index`th result of this yield statement (0-based).
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    Expr getImmediateResult(int index) {
      result =
        Synth::convertExprFromRaw(Synth::convertYieldStmtToRaw(this)
              .(Raw::YieldStmt)
              .getResult(index))
    }

    /**
     * Gets the `index`th result of this yield statement (0-based).
     */
    final Expr getResult(int index) { result = getImmediateResult(index).resolve() }

    /**
     * Gets any of the results of this yield statement.
     */
    final Expr getAResult() { result = getResult(_) }

    /**
     * Gets the number of results of this yield statement.
     */
    final int getNumberOfResults() { result = count(getAResult()) }
  }
}
