async = require 'async'
debug = require('debug')('meshblu-push-to-sharefile:share-file-controller')

class ShareFileContoller
  constructor: ({@shareFileService, @localFileSystemService}) ->

  start: (callback) =>
    debug 'starting...'

    async.parallel {
      remote: @shareFileService.getFilesForFolder
      local: @localFileSystemService.getFilesForFolder
    }, (error) =>
      return callback error if error?
      callback null

module.exports = ShareFileContoller
