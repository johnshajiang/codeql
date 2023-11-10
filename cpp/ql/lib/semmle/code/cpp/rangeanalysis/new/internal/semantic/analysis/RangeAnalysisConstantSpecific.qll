/**
 * C++-specific implementation of range analysis.
 */

private import semmle.code.cpp.rangeanalysis.new.internal.semantic.Semantic
private import semmle.code.cpp.rangeanalysis.new.internal.semantic.analysis.FloatDelta
private import RangeAnalysisImpl
private import codeql.rangeanalysis.RangeAnalysis

module CppLangImplConstant implements LangSig<Sem, FloatDelta> {
  /**
   * Ignore the bound on this expression.
   *
   * This predicate is to keep the results identical to the original Java implementation. It should be
   * removed once we have the new implementation matching the old results exactly.
   */
  predicate ignoreExprBound(SemExpr e) { none() }

  /**
   * Holds if `e >= bound` (if `upper = false`) or `e <= bound` (if `upper = true`).
   */
  predicate hasConstantBound(SemExpr e, float bound, boolean upper) { none() }

  /**
   * Holds if `e >= bound + delta` (if `upper = false`) or `e <= bound + delta` (if `upper = true`).
   */
  predicate hasBound(SemExpr e, SemExpr bound, float delta, boolean upper) { none() }
}
