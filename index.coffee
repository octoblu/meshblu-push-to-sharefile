'use strict';
util           = require 'util'
{EventEmitter} = require 'events'
debug          = require('debug')('meshblu-push-to-sharefile')
ShareFileService    = require './src/share-file-service'
ShareFileController = require './src/share-file-controller'

MESSAGE_SCHEMA = {}

OPTIONS_SCHEMA =
  type: 'object'
  properties:
    toFolder:
      type: 'string'
      required: true
    fromFolder:
      type: 'string'
      required: true

class Plugin extends EventEmitter
  constructor: ->
    @toFolder = null
    @options = {}
    @messageSchema = MESSAGE_SCHEMA
    @optionsSchema = OPTIONS_SCHEMA
    shareFileService = new ShareFileService
    @shareFileContoller = new ShareFileController {shareFileService}

  cancelAndStart: (@toFolder) =>
    return console.error 'invalid folder to sync to' unless @toFolder
    return console.error 'invalid folder to sync from' unless @fromFolder

    return unless @shareFileContoller.didChange {@toFolder, @fromFolder}
    @shareFileContoller.cancel =>
      @shareFileContoller.start {@toFolder, @fromFolder}

  onConfig: (device) =>
    @setOptions device.options

  setOptions: (options={}) =>
    {@fromFolder, @toFolder} = options
    @cancelAndStart()

module.exports =
  messageSchema: MESSAGE_SCHEMA
  optionsSchema: OPTIONS_SCHEMA
  Plugin: Plugin
