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
    remoteFolder:
      type: 'string'
      required: true
    localFolder:
      type: 'string'
      required: true

class Plugin extends EventEmitter
  constructor: ->
    @options = {}
    @messageSchema = MESSAGE_SCHEMA
    @optionsSchema = OPTIONS_SCHEMA
    shareFileService = new ShareFileService
    @shareFileContoller = new ShareFileController {shareFileService}

  cancelAndStart: (@remoteFolder) =>
    return console.error 'invalid folder to sync to' unless @remoteFolder
    return console.error 'invalid folder to sync from' unless @localFolder

    return unless @shareFileContoller.didChange {@remoteFolder, @localFolder}
    @shareFileContoller.cancel =>
      @shareFileContoller.start {@remoteFolder, @localFolder}

  onConfig: (device) =>
    @setOptions device.options

  setOptions: (options={}) =>
    {@localFolder, @remoteFolder} = options
    @cancelAndStart()

module.exports =
  messageSchema: MESSAGE_SCHEMA
  optionsSchema: OPTIONS_SCHEMA
  Plugin: Plugin
