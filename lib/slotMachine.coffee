sum = require('./hashingFunctions').sum

class SlotMachine
  constructor: (slots, hashingFn) ->
    @slots = slots
    @numSlots = @slots.length
    @hashingFn = hashingFn || sum

  pull: (string) ->
    str = string.replace(/\.(png|jpg|gif|)$/g, "")
    stringArray = str.split('')
    index = @_indexFor(stringArray)
    return [index, @slots[index]]

  _indexFor: (array) ->
    intArray = array.map(@_getCharInt)
    index = (@hashingFn(intArray) + intArray.length) % @numSlots
    Math.abs(index)

  _getCharInt: (char) -> parseInt char.charCodeAt(0) or 0

module.exports = SlotMachine
