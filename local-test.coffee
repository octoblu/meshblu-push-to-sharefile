localTestConfig        = require './local-test.json'
LocalFileSystemService = require './src/local-file-system-service'
ShareFileService       = require './src/share-file-service'
ShareFileController    = require './src/share-file-controller'

class LocalTest
  constructor: ->
    {accessToken, baseUrl} = localTestConfig
    {remoteFolder, localFolder} = localTestConfig
    return @fail new Error 'Missing accessToken in config' unless accessToken?
    return @fail new Error 'Missing baseUrl in config' unless baseUrl?
    return @fail new Error 'Missing remoteFolder in config' unless remoteFolder?
    return @fail new Error 'Missing localFolder in config' unless localFolder?

    shareFileService = new ShareFileService {accessToken, baseUrl, remoteFolder}
    localFileSystemService = new LocalFileSystemService {localFolder}
    @shareFileContoller = new ShareFileController {shareFileService, localFileSystemService}

  run: =>
    @shareFileContoller.start (error) =>
      return @fail error if error?
      console.log 'Everything is done. Time to go home.'

  fail: (error) =>
    console.error error.toString()
    process.exit 1

new LocalTest().run()
