import TestUtilities.dataflow.FlowTestCommon

module IRTest {
  private import semmle.code.cpp.ir.dataflow.DataFlow
  private import semmle.code.cpp.ir.IR
  private import semmle.code.cpp.controlflow.IRGuards

  /**
   * A `BarrierGuard` that stops flow to all occurrences of `x` within statement
   * S in `if (guarded(x)) S`.
   */
  // This is tested in `BarrierGuard.cpp`.
  predicate testBarrierGuard(IRGuardCondition g, Instruction checked, boolean isTrue) {
    g.(CallInstruction).getStaticCallTarget().getName() = "guarded" and
    checked = g.(CallInstruction).getPositionalArgument(0) and
    isTrue = true
  }

  /** Common data flow configuration to be used by tests. */
  class IRTestAllocationConfig extends DataFlow::Configuration {
    IRTestAllocationConfig() { this = "IRTestAllocationConfig" }

    override predicate isSource(DataFlow::Node source) {
      source.asExpr().(FunctionCall).getTarget().getName() = "source"
      or
      source.asParameter().getName().matches("source%")
    }

    override predicate isSink(DataFlow::Node sink) {
      exists(FunctionCall call |
        call.getTarget().getName() = "sink" and
        sink.asExpr() = call.getAnArgument()
      )
    }

    override predicate isBarrier(DataFlow::Node barrier) {
      barrier.asExpr().(VariableAccess).getTarget().hasName("barrier") or
      barrier = DataFlow::InstructionBarrierGuard<testBarrierGuard/3>::getABarrierNode()
    }
  }
}
