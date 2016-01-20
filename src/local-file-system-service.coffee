fs    = require 'fs-extra'
debug = require('debug')('meshblu-push-to-sharefile:local-file-system-controller')

class LocalFileSystemService
  constructor: ({@localFolder}) ->

  getFilesForFolder: (callback) =>
    debug 'retreiving files'
    files = []
    fs.walk @localFolder
      .on 'data', (item) =>
        files.push path: item.path
      .on 'end', =>
        debug "got #{files.length} files"
        callback null, files

module.exports = LocalFileSystemService
