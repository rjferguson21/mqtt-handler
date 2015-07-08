mqtt = require 'mqtt'

#
# conf =
#   host: 10.10.1.1
#   subscriptions: []
#

MqttHandler = (conf) ->
  self = this
  self.conf = conf
  self.handlers = {}

  # Establish connection
  self.client = mqtt.connect conf.host

  self.client.on 'connect', ->
    self.client.subscribe conf.subscriptions

  self.client.on 'message', (topic, message) ->
    self.handlers[topic]?(topic, message)

  return this

MqttHandler::register = (topic, fn) ->
  this.handlers[topic] = fn

module.exports = MqttHandler
