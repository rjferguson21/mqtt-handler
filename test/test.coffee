Handler = require '../index'
mqtt = require 'mqtt'

conf =
  subscriptions: ['presence', 'foo/#', 'bar']

conn = mqtt.connect 'mqtt://test.mosquitto.org'

handler = new Handler(conf, conn)

handler.register 'foo', (topic, message) ->
  console.log 'just foo'
  console.log topic, message.toString()

handler.register 'foo/bar', (topic, message) ->
  console.log 'fooo baaaaarrrrrrrrrrr'

handler.register 'foo/pooo', (topic, message) ->
  console.log 'fooo poooo'
