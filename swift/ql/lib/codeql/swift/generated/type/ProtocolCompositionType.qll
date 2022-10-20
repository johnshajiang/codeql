// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.Type

module Generated {
  class ProtocolCompositionType extends Synth::TProtocolCompositionType, Type {
    override string getAPrimaryQlClass() { result = "ProtocolCompositionType" }

    /**
     * Gets the `index`th member of this protocol composition type (0-based).
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    Type getImmediateMember(int index) {
      result =
        Synth::convertTypeFromRaw(Synth::convertProtocolCompositionTypeToRaw(this)
              .(Raw::ProtocolCompositionType)
              .getMember(index))
    }

    /**
     * Gets the `index`th member of this protocol composition type (0-based).
     */
    final Type getMember(int index) { result = getImmediateMember(index).resolve() }

    /**
     * Gets any of the members of this protocol composition type.
     */
    final Type getAMember() { result = getMember(_) }

    /**
     * Gets the number of members of this protocol composition type.
     */
    final int getNumberOfMembers() { result = count(getAMember()) }
  }
}
