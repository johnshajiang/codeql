// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.stmt.BraceStmt
import codeql.swift.elements.stmt.LabeledStmt

module Generated {
  class DoStmt extends Synth::TDoStmt, LabeledStmt {
    override string getAPrimaryQlClass() { result = "DoStmt" }

    /**
     * Gets the body of this do statement.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    BraceStmt getImmediateBody() {
      result =
        Synth::convertBraceStmtFromRaw(Synth::convertDoStmtToRaw(this).(Raw::DoStmt).getBody())
    }

    /**
     * Gets the body of this do statement.
     */
    final BraceStmt getBody() { result = getImmediateBody().resolve() }
  }
}
