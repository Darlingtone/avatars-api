router = require('express').Router()

ImageFiles  = require('../imageFiles.coffee')
SlotMachine = require('../slotMachine.coffee')
common      = require('./common.coffee')
imager      = require('../imager.coffee')

imageFiles = ImageFiles.allPaths()
imageSlotMachine = new SlotMachine(imageFiles)

router.param 'id', (req, res, next, id) ->
  [index, image] = imageSlotMachine.pull(id)
  req.imagePath = image
  next()

router.get '/:id', (req, res, next) ->
  res.setHeader('Content-Type', 'image/png')
  res.sendFile(req.imagePath)

# with custom size
router.get '/:size/:id', (req, res, next) ->
  imager.resize req.imagePath, req.params.size, (err, stdout) ->
    common.sendImage(err, stdout, req, res, next)

module.exports = router
