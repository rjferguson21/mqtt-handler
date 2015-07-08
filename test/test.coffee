Handler = require '../index'
mqtt = require 'mqtt'

conf =
  subscriptions: ['presence', 'foo', 'bar']

conn = mqtt.connect 'mqtt://test.mosquitto.org'

handler = new Handler(conf, conn)

handler.register 'presence', (topic, message) ->
  console.log topic, message.toString()

handler.register 'foo', (topic, message) ->
  console.log 'fooo'
  console.log topic, message.toString()
