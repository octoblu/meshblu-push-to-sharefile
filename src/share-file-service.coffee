_       = require 'lodash'
request = require 'request'
debug   = require('debug')('meshblu-push-to-sharefile:share-file-service')

class ShareFileService
  constructor: ({@baseUrl,@accessToken,@remoteFolder}) ->

  getFilesForFolder: (callback) =>
    debug 'retreiving files'
    folderId = 'hello'
    options =
      uri: "/Items(#{folderId})"
      qs:
        treeMode: 'manage'
        canCreateRootFolder: false
    @_request options, (error, files) =>
      debug 'found files', error: error.toString(), files: files
      return callback error if error?
      callback null, files

  _requestOptions: =>
    return {
      method: 'GET'
      baseUrl: @baseUrl
      auth:
        bearer: @accessToken
      json: true
    }

  _request: (options, callback) =>
    options = _.defaults @_requestOptions(), options
    debug 'options', options
    request options, (error, response, body) =>
      return callback error if error?
      return callback new Error body if response.statusCode > 299
      callback null, body

module.exports = ShareFileService
