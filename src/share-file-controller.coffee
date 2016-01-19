class ShareFileContoller
  constructor: ({@shareFileService}) ->

  start: ({@toFolder, @fromFolder}) =>

  didChange: ({toFolder, fromFolder}, callback) =>
    return false if toFolder == @toFolder and fromFolder == @fromFolder
    return true

  cancel: (callback) =>
    callback null

module.exports = ShareFileContoller
