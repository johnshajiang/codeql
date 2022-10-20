// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.stmt.CaseStmt
import codeql.swift.elements.stmt.LabeledStmt
import codeql.swift.elements.stmt.Stmt

module Generated {
  class DoCatchStmt extends Synth::TDoCatchStmt, LabeledStmt {
    override string getAPrimaryQlClass() { result = "DoCatchStmt" }

    /**
     * Gets the body of this do catch statement.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    Stmt getImmediateBody() {
      result =
        Synth::convertStmtFromRaw(Synth::convertDoCatchStmtToRaw(this).(Raw::DoCatchStmt).getBody())
    }

    /**
     * Gets the body of this do catch statement.
     */
    final Stmt getBody() { result = getImmediateBody().resolve() }

    /**
     * Gets the `index`th catch of this do catch statement (0-based).
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    CaseStmt getImmediateCatch(int index) {
      result =
        Synth::convertCaseStmtFromRaw(Synth::convertDoCatchStmtToRaw(this)
              .(Raw::DoCatchStmt)
              .getCatch(index))
    }

    /**
     * Gets the `index`th catch of this do catch statement (0-based).
     */
    final CaseStmt getCatch(int index) { result = getImmediateCatch(index).resolve() }

    /**
     * Gets any of the catches of this do catch statement.
     */
    final CaseStmt getACatch() { result = getCatch(_) }

    /**
     * Gets the number of catches of this do catch statement.
     */
    final int getNumberOfCatches() { result = count(getACatch()) }
  }
}
