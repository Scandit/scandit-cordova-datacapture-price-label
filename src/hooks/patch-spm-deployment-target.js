// Copyright 2026 Scandit AG. All rights reserved.

// TODO: Remove this hook after upgrading to cordova-ios >= 8.0.1
// (see https://github.com/apache/cordova-ios/pull/1616).

module.exports = function (context) {
  let projectRoot = context.cordova.findProjectRoot()
  let corePlugin = `${projectRoot}/plugins/scandit-cordova-datacapture-core`
  let patchSpmDeploymentTarget = require(`${corePlugin}/src/hooks/patch-spm-deployment-target`);
  return patchSpmDeploymentTarget(context);
}
