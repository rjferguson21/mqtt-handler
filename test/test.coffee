Handler = require '../index'

conf =
  subscriptions: ['presence', 'foo', 'bar']
  host: 'mqtt://test.mosquitto.org'

handler = new Handler(conf)

handler.register 'presence', (topic, message) ->
  console.log topic, message.toString()

handler.register 'foo', (topic, message) ->
  console.log 'fooo'
  console.log topic, message.toString()
