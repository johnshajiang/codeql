/**
 * @name Missing read or write permission configuration
 * @description Defining an incomplete set of permissions
 * @kind problem
 * @problem.severity warning
 * @security-severity 7.8
 * @id java/android/incomplete-provider-permissions
 * @tags security
 *       external/cwe/cwe-276
 * @precision medium
 */

import java
import semmle.code.xml.AndroidManifest

from AndroidProviderXmlElement provider
where
  not provider.getFile().(AndroidManifestXmlFile).isInBuildDirectory() and
  provider.isExported() and
  provider.hasIncompletePermissions()
select provider, "Exported provider has incomplete permissions."
