// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.SyntaxSugarType
import codeql.swift.elements.type.Type

module Generated {
  class UnarySyntaxSugarType extends Synth::TUnarySyntaxSugarType, SyntaxSugarType {
    /**
     * Gets the base type of this unary syntax sugar type.
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    Type getImmediateBaseType() {
      result =
        Synth::convertTypeFromRaw(Synth::convertUnarySyntaxSugarTypeToRaw(this)
              .(Raw::UnarySyntaxSugarType)
              .getBaseType())
    }

    /**
     * Gets the base type of this unary syntax sugar type.
     */
    final Type getBaseType() { result = getImmediateBaseType().resolve() }
  }
}
