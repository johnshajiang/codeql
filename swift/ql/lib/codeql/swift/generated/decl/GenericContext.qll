// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.Element
import codeql.swift.elements.decl.GenericTypeParamDecl

module Generated {
  class GenericContext extends Synth::TGenericContext, Element {
    /**
     * Gets the `index`th generic type parameter of this generic context (0-based).
     *
     * This includes nodes from the "hidden" AST. It can be overridden in subclasses to change the
     * behaviour of both the `Immediate` and non-`Immediate` versions.
     */
    GenericTypeParamDecl getImmediateGenericTypeParam(int index) {
      result =
        Synth::convertGenericTypeParamDeclFromRaw(Synth::convertGenericContextToRaw(this)
              .(Raw::GenericContext)
              .getGenericTypeParam(index))
    }

    /**
     * Gets the `index`th generic type parameter of this generic context (0-based).
     */
    final GenericTypeParamDecl getGenericTypeParam(int index) {
      result = getImmediateGenericTypeParam(index).resolve()
    }

    /**
     * Gets any of the generic type parameters of this generic context.
     */
    final GenericTypeParamDecl getAGenericTypeParam() { result = getGenericTypeParam(_) }

    /**
     * Gets the number of generic type parameters of this generic context.
     */
    final int getNumberOfGenericTypeParams() { result = count(getAGenericTypeParam()) }
  }
}
