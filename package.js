Package.describe({
  name: 'spacejamio:mconfig',
  summary: "App, package and service config from url params, environment variables and Meteor.settings."
});


Package.onUse(function (api) {
  api.use(['coffeescript', 'underscore', 'startup']);
  api.use(['application-configuration', 'service-configuration'], {weak: true});
  api.use(['spacejamio:underscore.string', 'spacejamio:loglevel', 'spacejamio:chai']);

  api.addFiles(['client/query-string.js', 'client/URLParams.coffee'], 'client');

//  api.addFiles([
//    'ConfigError.coffee',
//    'Config.coffee']);

  api.export('spacejam');
  api.export('URLParams', 'client');
});


Package.onTest(function (api) {
  //api.use(['application-configuration', 'service-configuration']);
  api.use(['spacejamio:mconfig', 'coffeescript', 'spacejamio:munit']);

  api.addFiles('tests/client/URLParamsTest.coffee', 'client');
//  api.addFiles(['tests/MeteorSettingsTest.coffee'], ['server']);
//  api.addFiles(['tests/helpersTest.coffee'], ['client', 'server']);
//  api.addFiles(['tests/utilTest.coffee'], ['client', 'server']);
//  api.addFiles(['tests/ConfigErrorTest.coffee'], ['client', 'server']);
//  api.addFiles(['tests/ConfigTest.coffee'], ['client', 'server']);
//  api.addFiles(['tests/SettingsTest.coffee'], ['client', 'server']);
});
