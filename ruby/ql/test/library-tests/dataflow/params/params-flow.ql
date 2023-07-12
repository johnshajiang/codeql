/**
 * @kind path-problem
 */

import codeql.ruby.AST
import TestUtilities.InlineFlowTest
import ValueFlowTest<DefaultFlowConfig>
import PathGraph

from ValueFlow::PathNode source, ValueFlow::PathNode sink
where ValueFlow::flowPath(source, sink)
select sink, source, sink, "$@", source, source.toString()
